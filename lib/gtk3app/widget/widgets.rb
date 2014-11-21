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
    # @app_menu = Gtk3App::Widgets::AppMenu.new do |key|...
    def initialize(window, *par, &block)
      @block = block
      window.add_events(Gdk::Event::BUTTON_PRESS_MASK) # TODO: code review
      window.signal_connect('button_press_event') do |w,e|
        self.popup(nil, nil, 3, e.time) if e.button == 3
      end
      super(*par)
    end
    def append_menu_item(key)
      super(key, &@block)
    end
  end

end
end
