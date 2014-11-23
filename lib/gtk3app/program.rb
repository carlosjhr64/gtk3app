module Gtk3App
  class Program
    using Rafini::Array

    def initialize(app)
      @window = Such::Window.new(:window!, 'delete-event'){quit!}
      @app_menu = Gtk3App::Widget::AppMenu.new(@window, :app_menu!) do |w,*_,s|
        self.method(w.key).call if s=='activate'
      end
      @fs = false
      @logo = Gdk::Pixbuf.new(*Such::Thing::PARAMETERS[:LOGO])
      @window.set_icon @logo

      if @app_menu.children.which{|item| item.key==:minime!}
        @mini = Such::Window.new(:mini, 'delete-event'){quit!}
        @mini.add Gtk::Image.new(pixbuf: @logo.scale(25,25))
        @mini_menu = Gtk3App::Widget::AppMenu.new(@mini, :mini_menu!) do |w,*_,s|
          self.method(w.key).call if s=='activate'
          minime! if s=='button_press_event'
        end
      end

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

    def minime!
      if @window.visible?
        w, h = Gdk.screen_width, Gdk.screen_height
        @window.hide
        @mini.keep_above=true
        @mini.move(w-25, h-25)
        @mini.show_all
      else
        @mini.hide
        @window.show
      end
    end

    def close!
      puts "Sooooo close!"
    end

    def quit!
      Gtk.main_quit
    end

  end
end
