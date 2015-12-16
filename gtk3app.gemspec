Gem::Specification.new do |s|

  s.name     = 'gtk3app'
  s.version  = '1.5.0'

  s.homepage = 'https://github.com/carlosjhr64/gtk3app'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2015-12-16'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
_Gtk3App_ provides a _Gtk3_ application stub.

It automatically provides for command line options parsing, user configuration, and minime windows.
DESCRIPTION

  s.summary = <<SUMMARY
_Gtk3App_ provides a _Gtk3_ application stub.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ["--main", "README.rdoc"]

  s.require_paths = ["lib"]
  s.files = %w(
README.rdoc
bin/gtk3app
data/VERSION
data/logo.png
data/ruby.png
lib/gtk3app.rb
lib/gtk3app/config.rb
lib/gtk3app/dialog/dialogs.rb
lib/gtk3app/gtk3app.rb
lib/gtk3app/program.rb
lib/gtk3app/slot.rb
lib/gtk3app/version.rb
lib/gtk3app/widget/widgets.rb
  )
  s.executables << 'gtk3app'
  s.add_runtime_dependency 'help_parser', '~> 1.2', '>= 1.2.0'
  s.add_runtime_dependency 'user_space', '~> 2.0', '>= 2.0.1'
  s.add_runtime_dependency 'rafini', '~> 1.2', '>= 1.2.0'
  s.add_runtime_dependency 'sys-proctable', '~> 0.9', '>= 0.9.4'
  s.add_runtime_dependency 'gtk3', '~> 2.2', '>= 2.2.4'
  s.add_runtime_dependency 'such', '~> 0.2', '>= 0.2.1'
  s.requirements << 'ruby: ruby 2.1.5p273 (2014-11-13 revision 48405) [x86_64-linux]'
  s.requirements << 'system: linux/bash'

end
