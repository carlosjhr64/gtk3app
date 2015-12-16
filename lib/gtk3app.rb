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
unless Gdk::RGBA.respond_to?(:parse)
  module Gdk
    class RGBA
      # For now just simple colors
      def self.parse(color)
        if /^#(?<r>\w\w)(?<g>\w\w)(?<b>\w\w)(?<a>\w\w)$/=~color
          r, g, b, a = r.to_i(16), g.to_i(16), b.to_i(16), a.to_i(16)
          return new r, g, b, a
        end
        if /^#(?<r>\w)(?<g>\w)(?<b>\w)$/=~color
          r, g, b, a = r.to_i(16)*17, g.to_i(16)*17, b.to_i(16)*17, 0
          return new r, g, b, a
        end
        raise "can only parse '#rrggbbaa' or '#rgb'"
      end
    end
  end
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
