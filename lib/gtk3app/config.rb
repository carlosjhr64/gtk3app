module Gtk3App

  # The gem's root directory
  APPDIR = File.dirname File.dirname __dir__

  a0 = Rafini::Empty::ARRAY
  h0 = Rafini::Empty::HASH
  s0 = Rafini::Empty::STRING

  CONFIG = {
    # The command line help in standard form.
    HELP: <<HELP,

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
    OPEN: 'gnome-open',

    SLOTS: 13, # The number of minime slots
    SLOTS_DBM: "#{XDG['CACHE']}/gtk3app/slots.sdbm", # slot management database
    SLOTS_OFFSET: [0,0], # The offset from the bottom right corner
    SLOTS_SCALE: [25,25], # The size of the slots

    Thing: { # The application MAY overwrite some these

      # Main window configuration
      WINDOW: a0, # Window.new's parameters
      window: h0, # window settings
      window!: [:WINDOW,:window],

      # Minime's configuration
      # Application SHOULD NOT modify these.
      MINI: a0,
      mini: {
        set_decorated: false,
      },
      mini!: [:MINI,:mini],

      # Fullscreen app-menu item
      # Application MAY modify :FS for language
      FS: ['Full Screen'],
      fs: h0,
      fs!: [:FS, :fs, 'activate'],

      # About app-menu item
      # Application MAY modify :ABOUT for language
      # Application SHOULD modify :about_dialog
      ABOUT: ['About'],
      about: h0,
      about!: [:ABOUT, :about, 'activate'],
      about_dialog: {
        set_program_name: 'Gtk3App',
        set_version: VERSION,
        set_copyright: '(c) 2014 CarlosJHR64',
        set_comments: 'A Gtk3 Application Stub',
        set_website: 'https://github.com/carlosjhr64/gtk3app',
        set_website_label: 'See it at GitHub!',
      },

      # Application SHOULD modify LOGO to use it's own logo image.
      LOGO: [file: "#{XDG['DATA']}/gtk3app/logo.png"],

      # Help app-menu item
      # Application MAY modify :HELP for language
      # Application SHOULD modify :HELP_FILE to their own help page.
      HELP: ['Help'],
      help: h0,
      help!: [:HELP, :help, 'activate'],
      HELP_FILE: 'https://github.com/carlosjhr64/gtk3app',

      # Minime's app-menu item.
      # Application MAY modify :MINIME for language.
      MINIME: ['Mini-me'],
      minime: h0,
      minime!: [:MINIME, :minime, 'activate'],

      # Quit app-menu item.
      # Application MAY modify :QUIT for language.
      QUIT: ['Quit'],
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
