# NOTE:
# Comments marked as NOTE are IMPORTANT!

# NOTE:
# Gtk3App will camelize the given filename of the application to get the module name.
module SimpleApp

  # Using the "I don't care" underscore variable to temporarily hold
  # which's espeak path to test if it's there to give to the ESPEAK constant.
  ESPEAK = ((_=`which espeak 2> /dev/null`.strip) and (_.length>0) ? _ : nil)

  # If the system has espeak,
  # says wut, else puts wut.
  def self.says(wut)
    if ESPEAK
      system "#{ESPEAK} \"#{wut}\" &"
    else
      puts wut
    end
  end

  # NOTE:
  # Gtk3App expects a module level run method to pass the main Window object.
  # Here it's SimpleApp.run.
  def self.run(window)

    # NOTE:
    # Once here, one can proceed as one normally does, "Gtk" style.
    window.set_title "My Application!"
    window.set_default_size 200, 100
    window.set_window_position :center

    vbox = Gtk::Box.new :vertical
    window.add vbox

    button1 = Gtk::Button.new label: 'Button #1'
    button2 = Gtk::Button.new label: 'Button #2'

    vbox.pack_start button1
    vbox.pack_start button2

    button1.signal_connect('clicked'){SimpleApp.says "You've pressed button number 1!"}
    button2.signal_connect('clicked'){SimpleApp.says "You've pressed button number 2!"}

    window.show_all

  end
end
