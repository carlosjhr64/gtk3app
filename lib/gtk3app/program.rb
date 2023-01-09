module Gtk3App
class << self
  # Gtk3App.run(version:String?, help:String?,
  #             klass:(Class | Module)?), appdir:String?, appname:String?,
  #             config:Hash?)
  def run(**kw)
    # :appdir must be evaluated here, else breaks UserSpace's heuristics
    kw[:appdir] ||= UserSpace.appdir
    ensure_keywords(kw)
    @options = HelpParser[kw[:version], kw[:help]]
    install(kw)

    Such::Thing.configure @@CONFIG
    @main = Such::Window.new :main! do |*_,e,signal|
      case signal
      when 'key-press-event'
        if e.keyval==@@CONFIG[:AppMenu]
          @appmenu.popup_at_widget @logo,
          Gdk::Gravity::NORTH_WEST,Gdk::Gravity::NORTH_WEST
        end
      when 'delete-event'
        quit!
      end
    end
    @main.set_decorated false if @options.notdecorated

    vbox = Such::Box.new @main, [:vertical]
    hbox = Such::Box.new vbox,  [:horizontal]

    size     = @@CONFIG[:LogoSize]
    @pixbuf  = GdkPixbuf::Pixbuf.new(file: @@CONFIG[:Logo]).scale(size,size)
    @logo    = Gtk3App::EventImage.new hbox, [pixbuf:@pixbuf]
    @appmenu = Gtk3App::AppMenu.new(@logo, :app_menu!) do |widget,*e,signal|
      case signal
      when 'activate'
        send widget.key
      when 'button_press_event'
        @logo_press_event.call(e[0].button) if @logo_press_event
      end
    end

    @stage   = Such::Expander.new vbox, :stage!
    @toolbar = Such::Expander.new hbox, :toolbar!

    if block_given?
      yield(@stage, @toolbar, @options)
    else
      kw[:klass]&.new(@stage, @toolbar, @options)
    end

    @minime = @fs = false
    @main.show_all
    Gtk.main
  end

  def raise_argument_error(kw)
    $stderr.puts <<~SIGNATURE
      Expected Signature:
        Gtk3App.run(version:String?, help:String?,
                    klass:Class?, appdir:String?, :appname:String?
                    config:Hash?)
    SIGNATURE
    raise ArgumentError, kw.inspect
  end

  def ensure_keywords(kw)
    raise_argument_error(kw) if
    kw.keys.any?{![:version,:help,:klass,:appdir,:appname,:config].include?_1}
    klass = kw[:klass]
    kw[:version] ||= (klass and defined? klass::VERSION)?
                     klass::VERSION : (defined? ::VERSION)? ::VERSION : VERSION
    kw[:help]    ||= (klass and defined? klass::HELP)?
                     klass::HELP : (defined? ::HELP)? ::HELP : HELP
    kw[:appname] ||= klass&.name&.downcase || File.basename($0)
    kw[:config]  ||= klass::CONFIG if klass and defined? klass::CONFIG
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
    system(@@CONFIG[:Open], @@CONFIG[:HelpFile])
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
      if @options.minime?
        @stage.show
        @toolbar.show
      end
    else
      @minime = true
      unless @options.notoggle
        @main.set_decorated false unless @options.notdecorated
        @main.set_keep_above true
      end
      @stage.set_expanded false
      @toolbar.set_expanded false
      if @options.minime?
        @stage.hide
        @toolbar.hide
      end
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
    stub.configures @@CONFIG

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
    # Pad-up klass::CONFIG and switch to it:
    if cfg = kw[:config]
      @@CONFIG.each do |k,v|
        if cfg.key? k
          $stderr.puts "Overriding Gtk3App::CONFIG[#{k}]" if $VERBOSE
        else
          cfg[k]=v
        end
      end
      @@CONFIG = cfg
    end
  end
end
end
