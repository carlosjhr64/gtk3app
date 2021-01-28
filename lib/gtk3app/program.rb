module Gtk3App
class << self
  # Gtk2App.run(version:String?, help:String?, klass:(Class | Module)?), appdir:String?, appname:String?, config:Hash?)
  def run(**kw)
    kw[:appdir] ||= UserSpace.appdir
    ensure_keywords(kw)
    @options = HelpParser[kw[:version], kw[:help]]
    install(kw)

    Such::Thing.configure CONFIG
    @main    = Such::Window.new  :main!, 'delete-event' do quit! end
    @main.set_decorated false if @options.notdecorated

    vbox     = Such::Box.new     @main,  [:vertical]
    hbox     = Such::Box.new      vbox,  [:horizontal]

    size    = CONFIG[:LogoSize]
    @pixbuf = GdkPixbuf::Pixbuf.new(file:CONFIG[:Logo]).scale(size,size)
    logo    = Gtk3App::EventImage.new hbox, [pixbuf:@pixbuf]
    Gtk3App::AppMenu.new(logo, :app_menu!) do |widget,*e,signal|
      case signal
      when 'activate'
        send widget.key
      when 'button_press_event'
        @logo_press_event.call(e[0].button) if @logo_press_event
      end
    end

    @stage   = Such::Expander.new vbox, :stage!
    @toolbar = Such::Expander.new hbox, :toolbar!

    kw[:klass]&.new(@stage, @toolbar, @options) or yield(@stage, @toolbar, @options)

    @minime = @fs = false
    @main.show_all
    Gtk.main
  end

  def raise_argument_error(kw)
    $stderr.puts 'Expected Signature:'
    $stderr.puts '  Gtk3App.run(version:String?, help:String?, :klass:Class?, appdir:String?, :appname:String? config:Hash?)'
    raise ArgumentError, kw.inspect
  end

  def ensure_keywords(kw)
    keys = [:version, :help, :klass, :appdir, :appname, :config]
    raise_argument_error(kw) if kw.keys.any?{not keys.include?_1}
    klass = kw[:klass]

    unless kw[:version]
      if klass and defined? klass::VERSION
        kw[:version] = klass::VERSION
      else
        kw[:version] = (defined? ::VERSION)? ::VERSION : VERSION
      end
    end

    unless kw[:help]
      if klass and defined? klass::HELP
        kw[:help] = klass::HELP
      else
        kw[:help] = (defined? ::HELP)? ::HELP : HELP
      end
    end

    kw[:appname] ||= klass&.name&.downcase || File.basename($0)

    unless kw[:config]
      if klass and defined? klass::CONFIG
        kw[:config] = klass::CONFIG
      end
    end
  end

  def transient(window)
    window.transient_for = @main
  end

  def logo_press_event(&block)
    @logo_press_event = block
  end

  def fs!
    @fs ? @main.unfullscreen : @main.fullscreen
    @fs = !@fs
  end

  def about!
    about = Such::AboutDialog.new :about_dialog
    transient about
    about.set_logo @pixbuf
    about.run
    about.destroy
  end

  def help!
    system "#{CONFIG[:Open]} '#{CONFIG[:HelpFile]}'"
  end

  def minime!
    if @minime
      @minime = false
      unless @options.notoggle
        @main.set_decorated true unless @options.notdecorated
        @main.set_keep_above false
      end
      @stage.set_expanded true
      @toolbar.set_expanded true
    else
      @minime = true
      unless @options.notoggle
        @main.set_decorated false unless @options.notdecorated
        @main.set_keep_above true
      end
      @stage.set_expanded false
      @toolbar.set_expanded false
      @main.resize 1,1
    end
  end

  using Rafini::Exception
  def quit!
    ursure = Gtk3App::YesNoDialog.new :quit_ursure!
    transient ursure
    return true unless ursure.ok?
    @finalize.call if @finalize
    Gtk.main_quit
    return false
  rescue # finalize raised exception
    $!.puts
    dialog = Such::MessageDialog.new
    transient dialog
    dialog.set_text $!.message
    dialog.run
    dialog.destroy
    return true
  end

  def finalize(&block)
    @finalize = block
  end


  using Rafini::String
  def install(kw)
    stub = UserSpace.new parser:RBON,
                         appname:'gtk3app',
                         config:"config-#{VERSION.semantic(0..1)}"
    stub.configures CONFIG

    # :klass and :config flags user wants xdg maintainance.
    # :appname, :appdir, and :version are sanity checks.
    if [:klass,:config,:appname,:appdir,:version].all?{kw[_1]}
      app = UserSpace.new parser:RBON,
                          # Will be a subdirectory in gtk3app:
                          appname:"gtk3app/#{kw[:appname]}",
                          appdir:kw[:appdir],
                          config:"config-#{kw[:version].semantic(0..1)}"
      app.configures kw[:config]
    end
    CONFIG.merge! kw[:config] if kw[:config]
  end
end
end
