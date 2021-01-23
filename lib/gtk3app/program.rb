module Gtk3App
class << self
  def run
    @options = get_options
    install

    Such::Thing.configure CONFIG
    @main    = Such::Window.new  :main!, 'delete-event' do quit! end
    @main.set_decorated false if @options.notdecorated

    vbox     = Such::Box.new     @main,  [:vertical]
    hbox     = Such::Box.new      vbox,  [:horizontal]

    size    = CONFIG[:LogoSize]
    @pixbuf = GdkPixbuf::Pixbuf.new(file:CONFIG[:Logo]).scale(size,size)
    logo    = Gtk3App::EventImage.new hbox, [pixbuf:@pixbuf]
    Gtk3App::AppMenu.new(logo, :app_menu!) do |w,*_,s|
      send(w.key) if s=='activate'
    end

    @container = Such::Expander.new vbox, :expander!
    @toolbar   = Such::Expander.new hbox, :expander!
    yield @container, @toolbar, @options

    @minime = @fs = false
    @main.show_all
    Gtk.main
  end

  def get_options
    help     = (defined? ::HELP)?    ::HELP    : HELP
    version  = (defined? ::VERSION)? ::VERSION : VERSION
    HelpParser[version, help]
  end

  def fs!
    @fs ? @main.unfullscreen : @main.fullscreen
    @fs = !@fs
  end

  def about!
    about = Such::AboutDialog.new :about_dialog
    about.transient_for = @main
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
      @container.set_expanded true
      @toolbar.set_expanded true
    else
      @minime = true
      unless @options.notoggle
        @main.set_decorated false unless @options.notdecorated
        @main.set_keep_above true
      end
      @container.set_expanded false
      @toolbar.set_expanded false
      @main.resize 1,1
    end
  end

  using Rafini::Exception
  def quit!
    ursure = Gtk3App::YesNoDialog.new :quit_ursure!
    ursure.transient_for = @main
    return unless ursure.ok?
    Gtk3App.finalize if Gtk3App.respond_to? :finalize
    Gtk.main_quit
  rescue
    $!.puts
  end

  using Rafini::String
  def install
    _ = UserSpace.new parser:RBON,
                      appname:'gtk3app',
                      config:"config-#{VERSION.semantic(0..1)}",
                      appdir:APPDIR
    _.configures CONFIG
  end
end
end
