module Gtk3App

  APPDIR = File.dirname File.dirname __dir__

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

    OPEN: 'gnome-open',

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
      about_dialog: {
        set_program_name: 'Gtk3App',
        set_version: VERSION,
        set_copyright: '(c) 2014 CarlosJHR64',
        set_comments: 'A Gtk3 Application Stub',
        set_website: 'https://github.com/carlosjhr64/gtk3app',
        set_website_label: 'See it at GitHub!',
      },
      LOGO: [file: "#{XDG['DATA']}/gtk3app/logo.png"],

      HELP: ['Help'],
      help: h0,
      help!: [:HELP, :help, 'activate'],
      HELP_FILE: 'https://github.com/carlosjhr64/gtk3app',

      MINIME: ['Mini-me'],
      minime: h0,
      minime!: [:MINIME, :minime, 'activate'],

      CLOSE: ['Close'],
      close: h0,
      close!: [:CLOSE, :close, 'activate'],

      QUIT: ['Quit'],
      quit: h0,
      quit!: [:QUIT, :quit, 'activate'],

      APP_MENU: a0,
      app_menu: {
        append_menu_item: [:fs!, :about!, :help!, :minime!, :close!, :quit!],
      },
      app_menu!: [:APP_MENU, :app_menu, s0],

    },
  }
end
