Gem::Specification.new do |s|

  s.name     = 'gtk3app'
  s.version  = '2.0.2'

  s.homepage = 'https://github.com/carlosjhr64/gtk3app'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2017-11-29'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Gtk3App provides a Gtk3 application stub.

It automatically provides for user configuration, and minime windows.
DESCRIPTION

  s.summary = <<SUMMARY
Gtk3App provides a Gtk3 application stub.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ['--main', 'README.rdoc']

  s.require_paths = ['lib']
  s.files = %w(
README.rdoc
data/VERSION
data/logo.png
data/ruby.png
lib/gtk3app.rb
lib/gtk3app/config.rb
lib/gtk3app/dialog/dialogs.rb
lib/gtk3app/gtk3app.rb
lib/gtk3app/program.rb
lib/gtk3app/slot.rb
lib/gtk3app/widget/widgets.rb
  )

  s.add_runtime_dependency 'user_space', '~> 3.0', '>= 3.0.0'
  s.add_runtime_dependency 'rafini', '~> 1.2', '>= 1.2.1'
  s.add_runtime_dependency 'gtk3', '~> 3.2', '>= 3.2.0'
  s.add_runtime_dependency 'such', '~> 0.4', '>= 0.4.0'
  s.requirements << 'ruby: ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]'

end
