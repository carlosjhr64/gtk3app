module Gtk3App
module Dialog

module Runs
  def initialize(*par,&block)
    @block = block
    super(*par)
  end

  def runs
    set_window_position(:center) if parent and not parent.visible?
    show_all
    response = run
    if block_given?
      response = yield(response)
    elsif @block
      response = @block.call(child, response)
    else
      response = (response==Gtk::ResponseType::OK)
    end
    destroy
    return response
  end

  # The following is just to save a bit of typing.
  
  def label(*par)
    Such::Label.new child, *par
  end

  def combo(*par)
    Such::ComboBoxText.new child, *par
  end

  def entry(*par)
    Such::Entry.new child, *par
  end
end

class CancelOk < Such::Dialog
  include Runs
  def initialize(*par)
    super
    add_button(Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL)
    add_button(Gtk::Stock::OK, Gtk::ResponseType::OK)
  end
end

class NoYes < Such::Dialog
  include Runs
  def initialize(*par)
    super
    add_button('_No', Gtk::ResponseType::CANCEL)
    add_button('_Yes', Gtk::ResponseType::OK)
  end
end

end
end
