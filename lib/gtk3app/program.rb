module Gtk3App
class << self
  # Gtk2App.run(appdir:String?, appname:String?, version:String?, config:Hash?, klass:(Class | Module)?)
  def run(**kw)
    @options = get_options
    kw[:appdir] = UserSpace.appdir unless kw[:appdir]
    install(**kw)

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
        Gtk3App.logo_press_event(e[0].button) if Gtk3App.respond_to? :logo_press_event
      end
    end

    @stage =   Such::Expander.new vbox, :stage!
    @toolbar = Such::Expander.new hbox, :toolbar!
    yield @stage, @toolbar, @options

    @minime = @fs = false
    @main.show_all
    Gtk.main
  end

  def get_options
    help     = (defined? ::HELP)?    ::HELP    : HELP
    version  = (defined? ::VERSION)? ::VERSION : VERSION
    HelpParser[version, help]
  end

  def transient(window)
    window.transient_for = @main
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
    Gtk3App.finalize if Gtk3App.respond_to? :finalize
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

  def raise_argument_error
    $stderr.puts 'Expected Signatures:'
    $stderr.puts '  Gtk3App.run'
    $stderr.puts '  Gtk3App.run(config:Hash)'
    $stderr.puts '  Gtk3App.run(appname:String, version:String, config:Hash, appdir:String?)'
    $stderr.puts '  Gtk3App.run(klass:(Class|Module), appdir:String?)'
    $stderr.puts 'Defaults appdir to UserSpace.appdir.'
    $stderr.puts "Got: #{kw.inspect}."
    raise ArgumentError
  end

  using Rafini::String
  def install(**kw)
    keys = [:klass,:appdir,:appname,:version,:config]
    raise_argument_error if kw.keys.any?{not keys.include?_1}
    if klass=kw[:klass]
      kw[:appname] ||= klass.name.downcase
      kw[:version] ||= klass::VERSION
      kw[:config]  ||= klass::CONFIG
    end
    raise_argument_error if keys[2..-2].any?{kw[_1]} and not keys[1..-1].all?{kw[_1]}

    stub = UserSpace.new parser:RBON,
                         appname:'gtk3app',
                         config:"config-#{VERSION.semantic(0..1)}"
    stub.configures CONFIG

    if keys[1..-1].all?{kw[_1]}
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
