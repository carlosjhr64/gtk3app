require 'gtk3app'

# Using the "I don't care" `_` variable to temporarily hold
# which's `espeak` path to test if it's there to give to the ESPEAK constant.
ESPEAK = ((_=`which espeak 2> /dev/null`.strip) and (_!='') ? _ : nil)

# If the system has `espeak`,
# `espeak wut`, else `puts wut`.
def says(wut)
  if ESPEAK
    spawn(ESPEAK, wut)
  else
    puts wut
  end
end

Gtk3App.run do |stage, toolbar|
  # toolbar is an Expander meant to hold an HBox.
  # It wont enforce an HBox, but what else could it meaningfully hold?
  hbox = Gtk::Box.new :horizontal
  toolbar.add hbox
  # Put a button in the HBox:
  button1 = Gtk::Button.new label: 'Button #1'
  button1.signal_connect('clicked') do
    says "You've pressed button number 1!"
  end
  hbox.pack_start button1

  # stage is an Expander meant to hold your workspace's container...
  # say a VBox here:
  vbox = Gtk::Box.new :vertical
  stage.add vbox
  # Put a button in the VBox:
  button2 = Gtk::Button.new label: 'Button #2'
  button2.signal_connect('clicked') do
    says "You've pressed button number 2!"
  end
  vbox.pack_start button2
end

exit # Ensure a clean exit
