module Gtk3App
module Widgets
  class Menu < Such::Menu
    def append_menu_item(key, &block)
      item = Such::MenuItem.new(self, key, &block)
      item.show
    end
  end

  class AppMenu < Menu
    # @app_menu = Gtk3App::Widgets::AppMenu.new do |key|...
    def initialize(window, key, &block)
      @block = block
      window.add_events(Gdk::Event::BUTTON_PRESS_MASK)
      window.signal_connect('button_press_event') do |w,e|
        self.popup(nil, nil, 3, e.time) if e.button == 3
      end
      super(key)
    end
    def append_menu_item(key)
      super(key, &@block)
    end
  end
end
end
