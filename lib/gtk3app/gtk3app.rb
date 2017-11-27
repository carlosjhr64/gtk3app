module Gtk3App
  using Rafini::String
  using Rafini::Hash
  using Rafini::Exception

  def self.config(mod)
    # Let's get NameErrors out of the way first
    appdir  = mod::APPDIR
    config  = mod::CONFIG
    version = mod::VERSION
    # Create the directory name for UserSpace.
    appname = mod.name.downcase
    appname.prepend('gtk3app/') unless mod==Gtk3App
    # UserSpace does its thing...
    user_space = UserSpace.new(
      YAML,
      ext: 'yml',
      config: "config-#{version.semantic(0..1)}",
      appname: appname,
      appdir: appdir
    )
    user_space.install unless user_space.version == version
    user_space.configures(config)
  rescue NameError
    $!.puts 'Application is not using APPDIR, VERSION, or CONFIG.'
  end

  def self.init(mod)
    Gtk3App.config mod
    if thing = mod::CONFIG[:thing]
      Such::Thing.configure thing
    end
  rescue NameError
    $!.puts 'Application is not using CONFIG.'
  end

  def self.main(app)
    Gtk3App.init Gtk3App
    Gtk3App.init app
    @program = Program.new app
    Gtk.main
  rescue StandardError
    $!.puts
    exit 1
  ensure
    @program.release if @program
  end
end
