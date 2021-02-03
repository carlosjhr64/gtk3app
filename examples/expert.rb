require 'gtk3app'

class Expert
  HELP = <<~HELP
    Usage:
      #{File.basename $0} [:options+]
    Options:
      --minime      \tReal minime
      --notoggle    \tMinime wont toggle decorated and keep above
      --notdecorated\tDont decorate window
      --notfour     \tDont show button four
  HELP

  VERSION = '1.2.3'

  CONFIG = {
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

  ESPEAK = ((_=`which espeak 2> /dev/null`.strip) and (_!='') ? _ : nil)

  def says(wut)
    if ESPEAK
      spawn(ESPEAK, wut)
    else
      puts wut
    end
  end

  def initialize(stage, toolbar, options)
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
    Gtk3App.logo_press_event do |button|
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
    Gtk3App.finalize do
      says 'Goodbye!'
    end
  end
end

# Just pass your app's Class to Gtk3App.run.
# Gtk3App will automatically maintain XDG files via UserSpace:
#   config => ~/.config/gtk3app/expert/
#   cache  => ~/.cache/gtk3app/expert/
#   data   => ~/.local/share/gtk3app/expert/
Gtk3App.run(klass:Expert)

exit # Ensure a clean exit
