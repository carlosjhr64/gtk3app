require 'gtk3app'

# Using the "I don't care" underscore variable to temporarily hold
# which's espeak path to test if it's there to give to the ESPEAK constant.
ESPEAK = ((_=`which espeak 2> /dev/null`.strip) and (_!='') ? _ : nil)

# If the system has espeak,
# says wut, else puts wut.
def says(wut)
  if ESPEAK
    spawn(ESPEAK, wut)
  else
    puts wut
  end
end

config = {
  main: { # Main Window
    set_title: "My Application",
    set_window_position: :center,
  }
}

Gtk3App.run(config:config) do |container, toolbar|
  hbox = Such::Box.new toolbar, [:horizontal]
  Such::Button.new hbox, [label: 'Button #1'] do
    says "You've pressed button number 1!"
  end
  Such::Button.new hbox, [label: 'Button #2'] do
    says "You've pressed button number 2!"
  end
  vbox = Such::Box.new container, [:vertical]
  Such::Button.new vbox, [label: 'Button #3'] do
    says "You've pressed button number 3!"
  end
  Such::Button.new vbox, [label: 'Button #4'] do
    says "You've pressed button number 4!"
  end
end

exit
