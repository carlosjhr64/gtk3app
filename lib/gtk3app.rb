module Gtk3App
  VERSION = '4.0.210117'
end

# Standard Libraries
require 'yaml'
require 'sdbm'

# Supporting Gems
require 'user_space'
require 'rafini'

# Workhorse Gems
require 'gtk3'
require 'such'
Such::Things.gtk_widget

### Gtk3App ###
# Configuration
require_relative 'gtk3app/config.rb'
# Custom Widgets
require_relative 'gtk3app/widget/widgets.rb'
# Program Flow
require_relative 'gtk3app/slot.rb'
require_relative 'gtk3app/program.rb'
require_relative 'gtk3app/gtk3app.rb'

# Requires:
#`ruby`
