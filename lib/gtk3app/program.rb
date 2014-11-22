module Gtk3App
  class Program

    def initialize(app)
      @window = Such::Window.new(:window!, 'destroy'){Gtk.main_quit} # For Now
      @app_menu = Gtk3App::Widget::AppMenu.new(@window, :app_menu!){|w, *_|self.method(w.key).call}
      app.run(@window)
    end

    def fs!
      puts "Fullscreen baby!"
    end

    def about!
      about = Such::AboutDialog.new :about_dialog
      begin
        logo = Gdk::Pixbuf.new(*Such::Thing::PARAMETERS[:LOGO])
        about.set_logo logo
      rescue IOError
        warn "cannot load logo: #{Such::Thing::PARAMETERS[:LOGO]}"
      end
      about.run
      about.destroy
    end

    def help!
      puts "HELP! I need somebody..."
    end

    def dock!
      puts "..on the bay."
    end

    def close!
      puts "Sooooo close!"
    end

    def quit!
      Gtk.main_quit
    end

  end
end
