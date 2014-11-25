module Gtk3App
module Widget

  class MenuItem < Such::MenuItem
    attr_accessor :key
  end

  class Menu < Such::Menu
    def append_menu_item(key, &block)
      item = MenuItem.new(self, key, &block)
      item.key = key
      item.show
    end
  end

  class AppMenu < Menu
    def initialize(window, *par, &block)
      @block = block
      window.add_events(Gdk::Event::BUTTON_PRESS_MASK)
      window.signal_connect('button_press_event') do |w,e|
        if e.button == 3
          self.popup(nil, nil, 3, e.time)
        else
          block.call(w,e,'button_press_event')
        end
      end
      super(*par)
    end

    def append_menu_item(key)
      block_given? ? super : super(key, &@block)
    end
  end

  class MainWindow < Such::Window
    def self.set_icon(file)
      @@icon = Gdk::Pixbuf.new(file: file)
    end

    def self.icon
      @@icon
    end

    def initialize(*par, &block)
      super(*par, &block)
      self.set_icon MainWindow.icon
    end

    def minime(x=CONFIG[:SlotsScale])
      self.set_default_size(x,x)
      self.add Gtk::Image.new(pixbuf: MainWindow.icon.scale(x,x)).show
    end
  end
end
end
