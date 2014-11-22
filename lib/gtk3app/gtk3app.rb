module Gtk3App
  using Rafini::String
  using Rafini::Hash

  UserSpace::OPTIONS[:parser] = YAML
  UserSpace::OPTIONS[:ext]    = 'yml'

  def self.config(mod, appname=mod.name.downcase, appdir=mod::APPDIR)
    appname.prepend('gtk3app/') unless mod==Gtk3App
    user_space = UserSpace.new(appname: appname, appdir: appdir)
    user_space.install unless user_space.version == mod::VERSION
    user_space.configures(mod::CONFIG)
  end

  def self.options(mod)
    version, help = mod::VERSION, mod::CONFIG[:HELP]
    options       = HELP_PARSER::HelpParser.new(version, help)
    $VERBOSE      = (options[:q])? nil : (options[:V])? true : false
    $DEBUG        = true if options[:d] # Don't get to turn off debug
  end

  def self.init(mod=Gtk3App)
    Gtk3App.config mod
    Gtk3App.options mod
    Such::Thing.configure mod::CONFIG[:Thing]
  end

  def self.run(appname)
    require appname=='demo' ? 'gtk3app/demo' : appname
    app = Object.const_get appname.camelize
    Gtk3App.init app
    Program.new app
    Gtk.main
  end

  def self.main
    begin
      Gtk3App.init
      appname = ARGV.shift
      if appname
        Gtk3App.run appname
      else
        puts Gtk3App::CONFIG[:HELP]
      end
    rescue HELP_PARSER::UsageException
      puts $!.message
      exit 0
    rescue HELP_PARSER::UsageError
      $stderr.puts $!.message
      exit 64
    end
  end
end
