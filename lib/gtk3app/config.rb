module Gtk3App
  a0 = Rafini::Empty::ARRAY
  h0 = Rafini::Empty::HASH
  s0 = Rafini::Empty::STRING

  CONFIG = {
    HELP: <<HELP,

This is the gtk3app stub.

Usage:

   gtk3app [options] appname ...

Options:

   -h --help      Show this help and exit.
   -v --version   Show the version and exit.
   -q --quiet     Be quiet, sets $VERBOSE to nil.
   -V --verbose   Sets $VERBOSE to true.
   -d --debug     Sets $DEBUG to true.

   appname        The name of the application to be run.

HELP

    Thing: { # supplements

      WINDOW: a0,
      window: h0,
      window!: [:WINDOW,:window],

      FS: ['Full Screen'],
      fs: h0,
      fs!: [:FS, :fs, 'activate'],

      ABOUT: ['About'],
      about: h0,
      about!: [:ABOUT, :about, 'activate'],

      APP_MENU: a0,
      app_menu: {append_menu_item: [:fs!, :about!]}, #, :help!, :dock!, :close!, :quit!]},
      app_menu!: [:APP_MENU, :app_menu, s0],

    },
  }
end
