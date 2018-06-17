gem 'help_parser', '~>5'
require 'help_parser'
require 'gtk3app'

module ExpertApp
  using Rafini::String

  VERSION = '2.1.1'
  OPTIONS = HelpParser[VERSION, <<-HELP]

This is ExpertApp, an example module for Gtk3App.

Usage:

  #{File.basename($0)} [:options+]

Options:

  --tts \t Use espeak.

  HELP

  APPDIR = File.dirname __dir__

  CONFIG = {

    thing: {

      window: {
        set_title: "The Expert App!",
        set_default_size: [200,100],
        set_window_position: :center,
      },

      # ExpertApp uses Such::Parts to create composite widgets.
      # Although only :MYBOX was required before,
      # now the automation done by Such will notice
      # missing items and will give a warning.
      # Just to keep the app warnings free
      # we explicitly define all keys.
      MYBOX: [:vertical],
      # Gtk3App uses Rafini, so might as use it.
      #    Rafini::Empty::ARRAY, Rafini::Empty::HASH, Rafini::Empty::STRING =
      #    [].freeze, {}.freeze, ''.freeze
      mybox: Rafini::Empty::ARRAY,
      # The empty string, '', tells "Such" not to connect to any signals.
      mybox!: [:MYBOX, :mybox, Rafini::Empty::STRING],

      # Going to explicitly state how to pack the button, and
      # factor it out to the :button symbol to be used by "one!" and "two!".
      button: {into: [:pack_start, expand:true, fill:true, padding:0]},

      ONE: [label: 'Button #1'],
      one: :button,
      one!: [:ONE, :one, 'clicked'],

      TWO: [label: 'Button #2'],
      two: :button,
      two!: [:TWO, :two, 'clicked'],

      about_dialog: {
        set_program_name: 'Expert App',
        set_version: VERSION.semantic(0..1),
        set_copyright: '(c) 2017 CarlosJHR64',
        set_comments: 'A Gtk3App Expert Example',
        set_website: 'https://github.com/carlosjhr64/gtk3app',
        set_website_label: 'See it at GitHub!',
      },

      HelpFile: 'https://github.com/carlosjhr64/gtk3app',

      Logo: "#{XDG['DATA']}/gtk3app/expertapp/ruby.png",

      PRESS_ONE: [label: 'Press One!'],
      press_one: Rafini::Empty::HASH,
      press_one!: [:PRESS_ONE, :press_one, 'activate'],

      PRESS_TWO: [label: 'Press Two!'],
      press_two: Rafini::Empty::HASH,
      press_two!: [:PRESS_TWO, :press_two, 'activate'],
    },
  }

  ESPEAK = ((_=`which espeak 2> /dev/null`.strip) and (_.length>0) ? _ : nil)
  def self.says(wut)
    if ESPEAK and OPTIONS.tts?
      system "#{ESPEAK} \"#{wut}\" &"
    else
      puts wut
    end
  end

  # We're going to create a Such::MyBox out of Such::Box with two buttons in it,
  # buttons one_Button and two_Button.
  # Such::Parts knows one_Button means Such::Button::new(:one!), and so on...
  Such::Parts.make('MyBox', 'Box', :one_Button, :two_Button)

  # This time, we want to be able to modify minime's app menu.
  def self.run(program)
    # Get program's main window and minime's menu.
    window, mini_menu = program.window, program.mini_menu
    warn 'Espeak not available.' if OPTIONS.tts? and !ESPEAK

    # Such::MyBox is our new composite widget.
    # Remember that mybox itself will not generate any signals as told in the configuration.
    # The signals will come from one_Button and two_Button.
    mybox = Such::MyBox.new(window, :mybox!) do |widget, signal|
      # "signal" is always 'clicked' b/c it's the only signal registered in this app,
      # but it's available to create different cases based on signal.
      # Here, we only care about which button was clicked.
      case widget
      when mybox.one_Button
        ExpertApp.says "You've pressed button number 1!"
      when mybox.two_Button
        no_yes = Gtk3App::Dialog::NoYes.new
        no_yes.transient_for = window
        no_yes.label.text = "Should I say!?"
        ExpertApp.says "You've pressed button number 2!" if no_yes.runs
      end
    end

    # Next we add to mini menu...
    mini_menu.append_menu_item(:press_one!){mybox.one_Button.clicked}
    mini_menu.append_menu_item(:press_two!){mybox.two_Button.clicked}

    mini_menu.show_all
    window.show_all
  end
end

Gtk3App.main(ExpertApp)
