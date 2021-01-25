# Supporting Gems
require 'help_parser'
require 'user_space'
require 'rafini'
require 'rbon'

# Workhorse Gems
require 'gtk3'
require 'such'
Such::Things.in Gtk::Widget

# This Gem
module Gtk3App
  VERSION = '4.0.210125'

  require 'gtk3app/config'
  require 'gtk3app/widgets'
  require 'gtk3app/program'
end
# Requires:
#`ruby`
