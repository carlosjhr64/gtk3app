module Demo
  # The application MUST provide it's APPDIR
  APPDIR  = File.dirname File.dirname __dir__
  # The application MUST provide it's VERSION
  VERSION = '0.0.0'
  # The application MUST provide it's CONFIG with the following keys:
  #   :HELP
  #     This is the command line help in standard form.
  #   :Thing
  #     This is a hash to configure Such::Thing::PARAMETERS.
  #     It may be an empty hash, ie. if the application won't use Such.
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

  # The application MUST provide its module#options= method to set @@options.
  def self.options=(h)
    @@options = h
  end

  # The application SHOULD provide its module#options method to give @@options.
  def self.options
    @@options
  end

  # The application MUST provide a module#run method to receive the main window and minime's menu.
  # The application is expected to add widgets to the main window.
  # The application is expected to add menu items to minime's menu.
  def self.run(window, mini_menu)
    window.show_all
  end

end
