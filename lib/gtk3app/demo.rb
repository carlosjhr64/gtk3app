module Demo
  APPDIR  = File.dirname File.dirname __dir__
  VERSION = '0.0.0'
  CONFIG = {
    HELP: <<HELP

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
  }
end
