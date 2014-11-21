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
      puts "I'm all about it!"
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
