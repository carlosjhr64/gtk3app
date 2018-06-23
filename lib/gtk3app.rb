module Gtk3App
  VERSION = '3.0.0'
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

require 'gtk3app/config.rb'

# Custom Widgets & Dialogs

require 'gtk3app/widget/widgets.rb'
require 'gtk3app/dialog/dialogs.rb'

# Program Flow

require 'gtk3app/slot.rb'
require 'gtk3app/program.rb'
require 'gtk3app/gtk3app.rb'

# Requires:
#`ruby`
