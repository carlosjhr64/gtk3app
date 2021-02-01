Gem::Specification.new do |s|

  s.name     = 'gtk3app'
  s.version  = '5.0.210201'

  s.homepage = 'https://github.com/carlosjhr64/gtk3app'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-02-01'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Gtk3App provides a
[Ruby Gnome Gtk3](https://rubygems.org/gems/gtk3)
application stub.

The stub provides you with two Expander containers.
One for a horizontal toolbar.
The other for your main stage area.
DESCRIPTION

  s.summary = <<SUMMARY
Gtk3App provides a
[Ruby Gnome Gtk3](https://rubygems.org/gems/gtk3)
application stub.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
data/logo.png
lib/gtk3app.rb
lib/gtk3app/config.rb
lib/gtk3app/program.rb
lib/gtk3app/widgets.rb
  )

  s.add_runtime_dependency 'help_parser', '~> 7.0', '>= 7.0.200907'
  s.add_runtime_dependency 'user_space', '~> 5.0', '>= 5.0.210123'
  s.add_runtime_dependency 'rafini', '~> 3.0', '>= 3.0.210112'
  s.add_runtime_dependency 'rbon', '~> 0.2', '>= 0.2.210125'
  s.add_runtime_dependency 'gtk3', '~> 3.4', '>= 3.4.3'
  s.add_runtime_dependency 'such', '~> 1.0', '>= 1.0.210117'
  s.requirements << 'ruby: ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]'

end
