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
begin
  # TODO: remove when fixed.
  Gdk::Selection::PRIMARY
  Gdk::Selection::CLIPBOARD
  Gdk::Event::BUTTON_PRESS_MASK
rescue NameError
  # This is surely a bug in the 2.2.* releases.
  # Just patching what I need for now.
  puts "Warning:  Gdk constants are missing."
  Gdk::Selection::PRIMARY ||= 1
  Gdk::Selection::CLIPBOARD ||= 69
  Gdk::Event::BUTTON_PRESS_MASK ||= 256
end

require 'such'
Such::Things.gtk_widget

### Gtk3App ###

# Configuration

require 'gtk3app/version.rb'
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
