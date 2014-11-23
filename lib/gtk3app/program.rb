module Gtk3App
  class Program

    def initialize(app)
      @window = Such::Window.new(:window!, 'delete-event'){quit!}
      @app_menu = Gtk3App::Widget::AppMenu.new(@window, :app_menu!){|w, *_|self.method(w.key).call}
      @fs = false
      @logo = Gdk::Pixbuf.new(*Such::Thing::PARAMETERS[:LOGO])
      @window.set_icon @logo
      app.run(@window)
    end

    def fs!
      @fs ? @window.unfullscreen : @window.fullscreen
      @fs = !@fs
    end

    def about!
      about = Such::AboutDialog.new :about_dialog
      begin
        about.set_logo @logo
      rescue IOError
        warn "cannot load logo: #{Such::Thing::PARAMETERS[:LOGO]}"
      end
      about.run
      about.destroy
    end

    def help!
      system "#{CONFIG[:OPEN]} '#{Such::Thing::PARAMETERS[:HELP_FILE]}'"
    end

    def dock!
      @window.iconify
    end

    def close!
      puts "Sooooo close!"
    end

    def quit!
      Gtk.main_quit
    end

  end
end
