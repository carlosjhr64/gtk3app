module Gtk3App
  class Program
    def initialize(app)
      @window = Such::Window.new(:window!, 'destroy') do
        Gtk.main_quit # For Now
      end
      @app_menu = Gtk3App::Widgets::AppMenu.new(@window, :app_menu!) do |key|
        puts key
      end
      app.run(@window)
    end
  end
end
