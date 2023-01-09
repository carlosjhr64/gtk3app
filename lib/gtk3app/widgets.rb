module Gtk3App
  class MenuItem < Such::MenuItem
    attr_accessor :key
  end

  class Menu < Such::Menu
    def add_menu_item(key, &block)
      item = MenuItem.new(self, key, &block)
      item.key = key
      item.show
    end
  end

  class AppMenu < Menu
    def initialize(logo, *par, &block)
      @block = block
      logo.add_events(Gdk::EventMask::BUTTON_PRESS_MASK)
      logo.signal_connect('button_press_event') do |w,e|
        if e.button == 3
          #self.popup(nil, nil, 3, e.time)
          self.popup_at_pointer #(nil, nil, 3, e.time)
        else
          block.call(w,e,'button_press_event')
        end
      end
      super(*par)
    end

    def add_menu_item(key, &block)
      super(key, &(block || @block))
    end
  end

  class EventImage < Such::EventBox
    def initialize(container, ...)
      super container
      Such::Image.new(self, ...)
    end
  end

  class YesNoDialog < Such::Dialog
    def initialize(...)
      super(...)
      add_button '_No', Gtk::ResponseType::CANCEL
      add_button '_Yes', Gtk::ResponseType::OK
    end

    def add_label(text)
      Such::Label.new(child).text = text
    end

    def ok?
      show_all
      response = run
      destroy
      response == Gtk::ResponseType::OK
    end
  end
end
