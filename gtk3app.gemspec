Gem::Specification.new do |s|

  s.name     = 'gtk3app'
  s.version  = '3.0.0'

  s.homepage = 'https://github.com/carlosjhr64/gtk3app'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2018-06-24'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Gtk3App provides a Gtk3 application stub.

It automatically provides for user configuration, and minime windows.
DESCRIPTION

  s.summary = <<SUMMARY
Gtk3App provides a Gtk3 application stub.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.rdoc
data/VERSION
data/logo.png
data/ruby.png
lib/gtk3app.rb
lib/gtk3app/config.rb
lib/gtk3app/gtk3app.rb
lib/gtk3app/program.rb
lib/gtk3app/slot.rb
lib/gtk3app/widget/widgets.rb
  )

  s.add_runtime_dependency 'user_space', '~> 3.0', '>= 3.0.0'
  s.add_runtime_dependency 'rafini', '~> 1.2', '>= 1.2.1'
  s.add_runtime_dependency 'gtk3', '~> 3.2'
  s.add_runtime_dependency 'such', '~> 0.4', '>= 0.4.0'
  s.requirements << 'ruby: ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]'

end
