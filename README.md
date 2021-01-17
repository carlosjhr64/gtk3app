# Gtk3App

* [VERSION 4.0.210117](https://github.com/carlosjhr64/gtk3app/releases)
* [github](https://www.github.com/carlosjhr64/gtk3app)
* [rubygems](https://rubygems.org/gems/gtk3app)

## DESCRIPTION:

Gtk3App provides a
[Ruby Gnome Gtk3](https://rubygems.org/gems/gtk3)
application stub.
It automatically provides for user configuration, application menu, and minime window.

## INSTALL:

```shell
$ sudo gem install gtk3app
```

## SYNOPSIS:

Given a module file such as `~./my_app.rb` providing `MyApp`, the module is expected to at least provide MyApp.run(program):

```ruby
module MyApp
  def self.run(program)
   window = program.window
   # develop as you would on a Gtk3::Window object...
   # ...probably a good idea to show all your work.
   window.show_all
   self
  end
  def self.finalyze
    # do any cleanups needed at quit time...
  end
end
Gtk3App.main(MyApp)
```

That's enough to get you going.
The three examples in the [./examples](https://github.com/carlosjhr64/gtk3app/tree/master/examples)
directory fully explains the rest of what Gtk3App can do for you.

## FEATURES:

* [Such](https://github.com/carlosjhr64/Such) wrappers.
* [Rafini](https://github.com/carlosjhr64/rafini) refinements.
* [UserSpace](https://github.com/carlosjhr64/user_space) XDG support.
* MiniMe, an alternative to the deprecated Gtk::StatusIcon.
* Popup Application Menu from window button 3 press event (standard left click on application).

## LICENSE:

* The MIT License

Copyright (c) 2021 CarlosJHR64

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## CREDITS

Stuff here I may have taken from:

* [softicons](http://www.softicons.com/application-icons/ruby-programming-icons-by-ahmad-galal/ruby-gtk-icon)
* [zetcode](http://zetcode.com/gui/rubygtk/)
