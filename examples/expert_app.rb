module ExpertApp
  using Rafini::String

  # Gtk3App always recognizes options -h, -v, -V, -q, and -d,
  # even though they are not mentioned in the help that follows:
  HELP = <<-HELP

This is ExpertApp, an example module for Gtk3App.

Usage:

  ruby -I ./lib ./bin/gkt3app ./examples/expert_app.rb [options]

Options:

  --tts   Use espeak.

  HELP

  APPDIR = File.dirname __dir__
  VERSION = '1.4.1'

  CONFIG = {

    Help: HELP,

    thing: {

      window: {
        set_title: "The Expert App!",
        set_default_size: [200,100],
        set_window_position: :center,
      },

      # ExpertApp uses Such::Parts to create composite widgets.
      # Although only :VBOX was required before,
      # now the automation done by Such will notice
      # missing items and will give a warning.
      # Just to keep the app warnings free
      # we explicitly define all keys.
      VBOX: [:vertical],
      # Gtk3App uses Rafini, so might as use it.
      #    Rafini::Empty::ARRAY, Rafini::Empty::HASH, Rafini::Empty::STRING =
      #    [].freeze, {}.freeze, ''.freeze
      vbox: Rafini::Empty::ARRAY,
      # The empty string, '', tells "Such" not to connect to any signals.
      vbox!: [:VBOX, :vbox, Rafini::Empty::STRING],

      ONE: [label: 'Button #1'],
      one: Rafini::Empty::HASH,
      one!: [:ONE, :one, 'clicked'],

      TWO: [label: 'Button #2'],
      two: Rafini::Empty::HASH,
      two!: [:TWO, :two, 'clicked'],

      about_dialog: {
        set_program_name: 'Expert App',
        set_version: VERSION.semantic(0..1),
        set_copyright: '(c) 2014 CarlosJHR64',
        set_comments: 'A Gtk3App Expert Example',
        set_website: 'https://github.com/carlosjhr64/gtk3app',
        set_website_label: 'See it at GitHub!',
      },

      HelpFile: 'https://github.com/carlosjhr64/gtk3app',

      Logo: "#{XDG['DATA']}/gtk3app/expertapp/ruby.png",

      PRESS_ONE: ['Press One!'],
      press_one: Rafini::Empty::HASH,
      press_one!: [:PRESS_ONE, :press_one, 'activate'],

      PRESS_TWO: ['Press Two!'],
      press_two: Rafini::Empty::HASH,
      press_two!: [:PRESS_TWO, :press_two, 'activate'],
    },
  }

  def self.options=(opts)
    @@options = opts
  end

  def self.options
    @@options
  end

  ESPEAK = ((_=`which espeak 2> /dev/null`.strip) and (_.length>0) ? _ : nil)
  def self.says(wut)
    if ESPEAK and ExpertApp.options[:tts]
      system "#{ESPEAK} \"#{wut}\" &"
    else
      puts wut
    end
  end

  # We're going to create a Such::VBox out of Such::Box with two buttons in it,
  # buttons one_Button and two_Button.
  # Such::Parts knows one_Button means Such::Button::new(:one!), and so on...
  Such::Parts.make('VBox', 'Box', :one_Button, :two_Button)

  # This time, we want to be able to modify minime's app menu.
  def self.run(program)
    # Get program's main window and minime's menu.
    window, mini_menu = program.window, program.mini_menu
    warn 'Espeak not available.' if ExpertApp.options[:tts] and !ESPEAK

    # Such::VBox is our new composite widget.
    # Remember that vbox itself will not generate any signals as told in the configuration.
    # The signals will come from one_Button and two_Button.
    vbox = Such::VBox.new(window, :vbox!) do |widget, signal|
      # "signal" is always 'clicked' b/c it's the only signal registered in this app,
      # but it's available to create different cases based on signal.
      # Here, we only care about which button was clicked.
      case widget
      when vbox.one_Button
        ExpertApp.says "You've pressed button number 1!"
      when vbox.two_Button
        no_yes = Gtk3App::Dialog::NoYes.new
        no_yes.label.text = "Should I say!?"
        ExpertApp.says "You've pressed button number 2!" if no_yes.runs
      end
    end

    # Next we add to mini menu...
    mini_menu.append_menu_item(:press_one!){vbox.one_Button.clicked}
    mini_menu.append_menu_item(:press_two!){vbox.two_Button.clicked}

    mini_menu.show_all
    window.show_all
  end
end
