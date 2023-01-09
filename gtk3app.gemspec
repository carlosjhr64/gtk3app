Gem::Specification.new do |s|

  s.name     = 'gtk3app'
  s.version  = '5.4.230109'

  s.homepage = 'https://github.com/carlosjhr64/gtk3app'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2023-01-09'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
`Gtk3App` provides a
[Ruby Gnome Gtk3](https://rubygems.org/gems/gtk3)
application stub.

The stub provides you with two Expander containers.
One for a horizontal toolbar.
The other for your main stage area.
DESCRIPTION

  s.summary = <<SUMMARY
`Gtk3App` provides a
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

  s.add_runtime_dependency 'help_parser', '~> 8.1', '>= 8.1.221206'
  s.add_runtime_dependency 'user_space', '~> 5.2', '>= 5.2.230101'
  s.add_runtime_dependency 'rafini', '~> 3.2', '>= 3.2.221213'
  s.add_runtime_dependency 'rbon', '~> 0.2', '>= 0.2.221217'
  s.add_runtime_dependency 'gtk3', '~> 4.0', '>= 4.0.5'
  s.add_runtime_dependency 'such', '~> 2.1', '>= 2.1.230106'
  s.requirements << 'ruby: ruby 3.2.0 (2022-12-25 revision a528908271) [aarch64-linux]'

end
