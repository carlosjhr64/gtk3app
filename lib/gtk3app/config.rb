module Gtk3App
  using Rafini::String

  # The gem's root directory
  APPDIR = File.dirname File.dirname __dir__

  a0 = Rafini::Empty::ARRAY
  h0 = Rafini::Empty::HASH
  s0 = Rafini::Empty::STRING

  # CONFIG follows the following conventions:
  # * Strings and numbers are mixed case.
  # * Arrays are all upper case (may except for arrays of length 1, see Such).
  # * Hashes are all lower case.
  # * Lower case bang! keys have special meaning in Such.
  # * Note that method keys may have mixed case as the method itself.
  CONFIG = {
    # The command line help in standard form.
    Help: <<HELP,

This is the gtk3app stub.

Usage:

   gtk3app [options] appname ...

Options:

   -h --help      Show this help and exit.
   -v --version   Show the version and exit.
   -q --quiet     Set $VERBOSE to nil.
   -V --verbose   Set $VERBOSE to true.
   -d --debug     Set $DEBUG to true.

   appname        The name of the application to be run.

HELP

    # The command to open with default application
    Open: 'gnome-open',

    Slots: 13, # The number of minime slots
    SlotsDBM: "#{XDG['CACHE']}/gtk3app/slots.sdbm", # slot management database
    SLOTS_OFFSET: [0,0], # The offset from the bottom right corner
    SlotsScale: 25, # The size of the slots
    SlotsOrientation: :horizontal,

    thing: { # The application MAY overwrite some these

      # Main window configuration
      WINDOW: a0, # Window.new's parameters
      window: h0, # window settings
      window!: [:WINDOW,:window],

      # Minime's configuration
      # Application SHOULD NOT modify these.
      MINI: a0,
      mini: {
        set_decorated: false,
        minime: a0,
      },
      mini!: [:MINI,:mini],

      # Fullscreen app-menu item
      # Application MAY modify :FS for language
      FS: [label: 'Full Screen'],
      fs: h0,
      fs!: [:FS, :fs, 'activate'],

      # About app-menu item
      # Application MAY modify :ABOUT for language
      # Application SHOULD modify :about_dialog
      ABOUT: [label: 'About'],
      about: h0,
      about!: [:ABOUT, :about, 'activate'],
      about_dialog: {
        set_program_name: 'Gtk3App',
        set_version: VERSION.semantic(0..1),
        set_copyright: '(c) 2014 CarlosJHR64',
        set_comments: 'A Gtk3 Application Stub',
        set_website: 'https://github.com/carlosjhr64/gtk3app',
        set_website_label: 'See it at GitHub!',
      },
      # Application SHOULD modify LOGO to use it's own logo image.
      Logo: "#{XDG['DATA']}/gtk3app/logo.png",
      # Application SHOULD modify :HelpFile to their own help page.
      HelpFile: 'https://github.com/carlosjhr64/gtk3app',
      # By convention, I'm using mix case for simple String configurations in here thing.

      # Help app-menu item
      # Application MAY modify :HELP for language
      HELP: [label: 'Help'],
      help: h0,
      help!: [:HELP, :help, 'activate'],

      # Minime's app-menu item.
      # Application MAY modify :MINIME for language.
      MINIME: [label: 'Mini-me'],
      minime: h0,
      minime!: [:MINIME, :minime, 'activate'],

      # Quit app-menu item.
      # Application MAY modify :QUIT for language.
      QUIT: [label: 'Quit'],
      quit: h0,
      quit!: [:QUIT, :quit, 'activate'],

      # The app menu configuration.
      # The application MAY ONLY modify app_menu.append_menu_item
      # by removing un-wanted app menu items.
      APP_MENU: a0,
      app_menu: {
        append_menu_item: [:fs!, :about!, :help!, :minime!, :quit!],
      },
      app_menu!: [:APP_MENU, :app_menu, s0],

      # Minime's app-menu configuration.
      # The application SHOULD NOT modify
      # (the application will have the opportunity later to modify
      # minime's app-menu directly).
      MINI_MENU: a0,
      mini_menu: {
        append_menu_item: [:quit!],
      },
      mini_menu!: [:MINI_MENU, :mini_menu, s0],

    },
  }
end
