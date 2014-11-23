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

      @mini_menu = nil
      if @app_menu.children.which{|item| item.key==:minime!}
        @mini = Such::Window.new(:mini, 'delete-event'){quit!}
        @mini.set_default_size(*CONFIG[:SLOTS_SCALE])
        @mini.add Gtk::Image.new(pixbuf: @logo.scale(*CONFIG[:SLOTS_SCALE]))
        @mini_menu = Gtk3App::Widget::AppMenu.new(@mini, :mini_menu!) do |w,*_,s|
          self.method(w.key).call if s=='activate'
          minime! if s=='button_press_event'
        end
      end

      case app.method(:run).arity
      when 1 then app.run(@window)
      when 2 then app.run(@window, @mini_menu)
      else raise "Application did not provide run method."
      end
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
        @slot = Slot.get
        if @slot
          a, b = CONFIG[:SLOTS_SCALE]
          x, y = CONFIG[:SLOTS_OFFSET]
          w, h = Gdk.screen_width, Gdk.screen_height
          @mini.move(w-@slot*a+x, h-b+y)
          @mini.keep_above=true
          @window.hide
          @mini.show_all
        end
      else
        Slot.release(@slot) if @slot
        @mini.hide
        @window.show
      end
    end

    def quit!
      Slot.release(@slot) if @slot
      Gtk.main_quit
    end

  end
end
