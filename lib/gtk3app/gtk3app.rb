module Gtk3App
  using Rafini::String
  using Rafini::Hash
  using Rafini::Exception

  UserSpace::OPTIONS[:parser] = YAML
  UserSpace::OPTIONS[:ext]    = 'yml'

  def self.config(mod)
    # Let's get NameErrors out of the way first
    appdir  = mod::APPDIR
    config  = mod::CONFIG
    version = mod::VERSION
    # Create the directory name for UserSpace.
    appname = mod.name.downcase
    appname.prepend('gtk3app/') unless mod==Gtk3App
    # UserSpace does its thing...
    user_space = UserSpace.new(appname: appname, appdir: appdir)
    user_space.install unless user_space.version == version
    user_space.configures(config)
  rescue NameError
    $!.puts 'Application is not using APPDIR, VERSION, or CONFIG.'
  end

  def self.options=(h)
    @@options=h
  end

  def self.options(mod=nil)
    if mod
      version, help = mod::VERSION, mod::CONFIG[:Help]
      if help
        # HelpParser enforces -h and -v for help and version respectively.
        # To that we add -V, -q, and -d for verbose, quiet, and debug respectively.
        options = HELP_PARSER::HelpParser.new(version, help, {verbose: :V, quiet: :q, debug: :d})
        $VERBOSE = (options[:q])? nil : (options[:V])? true : false
        $DEBUG = true if options[:d] # Don't get to turn off debug
        mod.options = options
      end
    else
      @@options
    end
  rescue NoMethodError
    $!.puts 'Application is not providing options setter.'
  rescue NameError
    $!.puts 'Application is not using VERSION or CONFIG.'
  end

  def self.init(mod=Gtk3App)
    Gtk3App.config mod
    Gtk3App.options mod
    if thing = mod::CONFIG[:thing]
      Such::Thing.configure thing
    end
  rescue NameError
    $!.puts 'Application is not using CONFIG.'
  end

  def self.run(appname)
    require appname
    app = Object.const_get File.basename(appname, '.rb').camelize
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
        puts CONFIG[:Help]
      end
    rescue HELP_PARSER::UsageException
      puts $!.message
      exit 0
    rescue HELP_PARSER::UsageError
      $stderr.puts $!.message
      exit 64
    rescue Exception
      $!.puts
      exit 1
    end
  end
end
