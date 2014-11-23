module Demo

  APPDIR  = File.dirname File.dirname __dir__
  VERSION = '0.0.0'

  CONFIG = {
    HELP: <<HELP,

This is the demo app.

Usage:

   gtk3app demo

Options:

   -h --help      Show this help and exit.
   -v --version   Show the version and exit.
   -q --quiet     Be quiet, sets $VERBOSE to nil.
   -V --verbose   Sets $VERBOSE to true.
   -d --debug     Sets $DEBUG to true.

HELP

    Thing: {
      window: {
        set_title: 'Demo',
        set_default_size: [404,250],
        set_window_position: :center,
      },
    },
  }

  def self.options=(h)
    @@options = h
  end

  def self.options
    @@options
  end

  def self.run(window)
    window.show_all
  end

end
