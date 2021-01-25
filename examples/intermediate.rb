require 'gtk3app'

# Gtk3App uses HelpParser.
# If you provide ::HELP and ::VERSION,
# Gtk3App will use them.
HELP = <<HELP
Usage:
  #{File.basename $0} [:options+]
Options:
  --notoggle    \tMinime wont toggle decorated and keep above
  --notdecorated\tDont decorate window
  --notfour     \tDont show button four
HELP
VERSION = '1.0.0'

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

# Use `finalize` to do any final cleanups
def Gtk3App.finalize
  says 'Goodbye!'
end

# Mouse button 3 on logo will give Gtk3App's main menu, but
# you can add you own actions on button 1 and 2 using
# `logo_press_event`.
def Gtk3App.logo_press_event(button)
  dialog = Such::MessageDialog.new
  # dialog is transient for main window
  Gtk3App.transient dialog
  case button
  when 1
    message = 'Mouse button 1 on logo!'
  when 2
    message = 'Mouse button 2 on logo!'
  end
  dialog.set_text message
  dialog.run
  dialog.destroy
end

# You can update Gtk3App's `CONFIG`
# with your own config:
config = {
  main: { # Main Window
    set_title: 'My App',
    set_window_position: :center,
  },
  about_dialog: {
    set_program_name: 'My App',
    set_version: VERSION,
    set_copyright: '(c) 2021 Me!',
    set_comments: 'A very useful app by me.',
   #set_website: '',
   #set_website_label: '',
  },
}

# Just pass your own config to `run`:
Gtk3App.run(config:config) do |stage, toolbar, options|
  hbox = Such::Box.new toolbar, [:horizontal]
  # Such::Widget is a wrap on Gtk::Widget that automates many things...
  Such::Button.new hbox, [label: 'Button #1'] do
    says "You've pressed button number 1!"
  end
  Such::Button.new hbox, [label: 'Button #2'] do
    says "You've pressed button number 2!"
  end
  vbox = Such::Box.new stage, [:vertical]
  Such::Button.new vbox, [label: 'Button #3'] do
    says "You've pressed button number 3!"
  end
  unless options.notfour
    Such::Button.new vbox, [label: 'Button #4'] do
      says "You've pressed button number 4!"
    end
  end
end

# Ensure a clean exit(0)
exit