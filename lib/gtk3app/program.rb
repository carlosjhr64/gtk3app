module Gtk3App
  class Program
    using Rafini::Array

    def initialize(app)
      Widget::MainWindow.set_icon Such::Thing::PARAMETERS[:Logo]

      @window = Widget::MainWindow.new(:window!, 'delete-event'){quit!}

      @app_menu = Widget::AppMenu.new(@window, :app_menu!) do |w,*_,s|
        self.method(w.key).call if s=='activate'
      end

      @fs = false

      @mini_menu = nil
      if @app_menu.children.which{|item| item.key==:minime!}
        @mini = Widget::MainWindow.new(:mini, 'delete-event'){quit!}
        @mini_menu = Widget::AppMenu.new(@mini, :mini_menu!) do |w,*_,s|
          self.method(w.key).call if s=='activate'
          minime! if s=='button_press_event'
        end
      end

      case app.method(:run).arity
      when 1 then app.run(@window)
      when 2 then app.run(@window, @mini_menu)
      else raise "Application run method should have 2 parameters."
      end
    end

    def fs!
      @fs ? @window.unfullscreen : @window.fullscreen
      @fs = !@fs
    end

    def about!
      about = Such::AboutDialog.new :about_dialog
      about.set_logo Widget::MainWindow.icon
      about.run
      about.destroy
    end

    def help!
      system "#{CONFIG[:Open]} '#{Such::Thing::PARAMETERS[:HelpFile]}'"
    end

    def minime!
      if @window.visible?
        @slot = Slot.get
        if @slot
          s = CONFIG[:SlotsScale]
          x, y = CONFIG[:SLOTS_OFFSET]
          w, h = Gdk.screen_width, Gdk.screen_height
          @mini.move(w-@slot*s+x, h-s+y)
          @mini.keep_above=true
          @window.hide
          @mini.show
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
