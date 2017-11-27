gem 'help_parser', '~>5'
require 'help_parser'
require 'gtk3app'

# In SimpleApp, most of the help Gtk3App provides was ignored.
# Gtk3App can take care of:
#    * XDG directories CONFIG, CACHE, and DATA
#    * configuration file
#    * The about, help, quit, minime, and fullscreen applicaton menu items.
# But you need to provide the right plugs as shown below.
module IntermediateApp
  using Rafini::String

  # Gtk3App tests the module's VERSION against that found in XDG[DATA]/gtk3app/modname/VERSION
  # to check if it needs to install (or reinstall) the XDG directories.
  VERSION = '2.0.1' # One can check this is the same as that in data/VERSION.

  OPTIONS = HelpParser[VERSION, <<-HELP]
This is IntermediaApp, an example module for Gtk3App.
Options:
  --tts\tUse espeak.
  HELP

  # APPDIR tells Gtk3App where to look for "seeding" files for the user's XDG directories.
  # It will copy APPDIR/data, APPDIR/config, and APPDIR/cache to
  # XDG[DATA]/gtk3app/modname, XDG[CONFIG]/gtk3app/modname, and XDG[CACHE]/gtk3app/modname
  # respectively.  One should at least have the APPDIR/data/VERSION file to copy over.
  APPDIR = File.dirname __dir__ # The root is a directory down from here.

  # Whereas "file_name" is camelized to "FileName" to create the module's name,
  # the module's name is downcased to "filename" create the XDG directories.  :-??


  # Gtk3App will seed the user's configuration directory with the application's CONFIG hash.
  # It's a YAML dump into XDG[CONFIG]/gtk3app/modname/config.yml
  # For IntermediateApp in Fedora 20 Linux, it's
  #    ~/.config/gtk3app/intermediateapp/config.yml
  CONFIG = {

    # Gtk3App was primarily design to use "Such", a wrapper for Gtk.
    # Gtk3App will use the CONFIG[:Thing] hash to configure Such::Thing::PARAMETERS.
    # "Such" allows one to take out what's essentially configuration out of the main code.
    thing: {
      # By convention, use lowercase keys for hashes.
      # Hashes are used for methods=>args mappings.
      # Gtk3App uses :window! to configure the main window
      # which is translated to *[:WINDOW, :window] by "Such".
      # One can override these keys with the module's own custome settings.
      window: {
        set_title: "My Intermediate App!",
        set_default_size: [200,100],
        set_window_position: :center,
      },
      # One can check the keys used by Gtk3App in it's own CONFIG[:Thing].
      # Gtk3App::CONFIG[:Thing] can also be read (and configured) in
      #    ~/.config/gtk3app/config.yml
      # :VBOX is not being used by Gtk3App, so it's safe to use to configure the vbox.
      # Uppercase keys are used for arrays, which are used  as parameters of the constructor.
      VBOX: [:vertical],
      # Normally, one needs to tell the widget how the pack itself into the parent, but
      # "Such" has some reasonable defaults that makes the following commented out code
      # unnecessary.
      # vbox: { into: [:add]} # The box will be adding itself into the window.
      ONE: [label: 'Button #1'],
      TWO: [label: 'Button #2'],
      # "Such" packs into Box with pack_start by default, so the following code is not needed:
      # one: {into: [:pack_start, ...pack starts parameters...]}
      # But if one needs to further configure the pack, that's where it is done.
      # Next, we override Gtk3App's :about_dialog with our application's about info:
      about_dialog: {
        set_program_name: 'Intermediate App',
        set_version: VERSION.semantic(0..1),
        set_copyright: '(c) 2017 CarlosJHR64',
        set_comments: 'A Gtk3App Intermediate Example',
        set_website: 'https://github.com/carlosjhr64/gtk3app',
        set_website_label: 'See it at GitHub!',
      },
      # Although here it's the same as Gtk3App,
      # one is expected to set the application's own help file:
      HelpFile: 'https://github.com/carlosjhr64/gtk3app',
      # And the application's own logo:
      Logo: "#{XDG['DATA']}/gtk3app/intermediateapp/ruby.png",
      # Note that ruby.png gets copied over from data/ruby.png.
    },

  }

  ESPEAK = ((_=`which espeak 2> /dev/null`.strip) and (_.length>0) ? _ : nil)
  def self.says(wut)
    if ESPEAK and OPTIONS.tts?
      system "#{ESPEAK} \"#{wut}\" &"
    else
      puts wut
    end
  end

  def self.run(program)
    # Get program's main window.
    window = program.window
    # Warn user that espeak is not available if asked for tts.
    warn 'Espeak not available.' if OPTIONS.tts? and !ESPEAK

    # By convention, I put the container first on the parameters list.
    # But order is not important, "Such" knows what to do based on the class given.
    vbox = Such::Box.new window, :VBOX

    # Be convention, I put the String signal last.
    Such::Button.new(vbox, :ONE, 'clicked') do
      IntermediateApp.says "You've pressed button number 1!"
    end
    # Note that "Such" will assume a 'clicked' signal if none is given.
    Such::Button.new(vbox, :TWO){IntermediateApp.says "You've pressed button number 2!"}

    window.show_all
  end
end

Gtk3App.main(IntermediateApp)
