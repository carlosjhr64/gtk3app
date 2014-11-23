# Standard Libraries
require 'yaml'
require 'sdbm'

# Supporting Gems
require 'help_parser'
require 'user_space'
require 'rafini'
require 'sys/proctable'

# Workhorse Gems
require 'gtk3'
require 'such'
Such::Things.gtk_widget

### Gtk3App ###
# Configuration
require 'gtk3app/version.rb'
require 'gtk3app/config.rb'
# Custom Widgets
require 'gtk3app/widget/widgets.rb'
# Program Flow
require 'gtk3app/slot.rb'
require 'gtk3app/program.rb'
require 'gtk3app/gtk3app.rb'

# Requires:
#`ruby`
