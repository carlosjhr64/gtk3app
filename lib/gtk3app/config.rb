module Gtk3App
  using Rafini::String # provides String#semantic
  extend Rafini::Empty # provides s0, a0, and h0.

  HELP = <<~HELP
    Usage:
      #{File.basename $0} [:options+]
    Options:
      --notoggle    	Minime wont toggle decorated and keep above
      --notdecorated	Dont decorate window
  HELP

  # CONFIG follows the following conventions:
  # * Strings and numbers are mixed case.
  # * Arrays are all upper case (may except for arrays of length 1, see Such).
  # * Hashes are all lower case.
  # * Lower case bang! keys have special meaning in Such.
  # * Note that method keys may have mixed case as the method itself.
  CONFIG = {
    # Application SHOULD modify LOGO to use it's own logo image.
    Logo: "#{UserSpace::XDG['data']}/gtk3app/logo.png",
    # Scale logo to this size.
    LogoSize: 25,

    # The command to open with default application
    Open: 'xdg-open',

    # Main window configuration
    MAIN: a0, # Window.new's parameters
    main: h0, # window settings
    main!: [:MAIN,:main],

    # Expander stage configuration
    STAGE: a0,
    stage: {set_expanded:true},
    stage!: [:STAGE, :stage],

    # Expander toolbar configuration
    TOOLBAR: a0,
    toolbar: {set_expanded:true},
    toolbar!: [:TOOLBAR, :toolbar],

    # Fullscreen app-menu item
    # Application MAY modify :FS for language
    FS: [label: 'Full Screen'],
    fs: h0,
    fs!: [:FS, :fs, 'activate'],

    # About app-menu item
    # Application MAY modify :ABOUT for language
    # Application SHOULD modify :about_dialog
    ABOUT: [label: 'About'],
    about: h0,
    about!: [:ABOUT, :about, 'activate'],
    about_dialog: {
      set_program_name: 'Gtk3App',
      set_version: VERSION.semantic(0..1),
      set_copyright: '(c) 2021 CarlosJHR64',
      set_comments: 'A Gtk3 Application Stub',
      set_website: 'https://github.com/carlosjhr64/gtk3app',
      set_website_label: 'See it at GitHub!',
    },
    # Application SHOULD modify :HelpFile to their own help page.
    HelpFile: 'https://github.com/carlosjhr64/gtk3app',

    # Help app-menu item
    # Application MAY modify :HELP for language
    HELP: [label: 'Help'],
    help: h0,
    help!: [:HELP, :help, 'activate'],

    # Minime's app-menu item.
    # Application MAY modify :MINIME for language.
    MINIME: [label: 'Minime'],
    minime: h0,
    minime!: [:MINIME, :minime, 'activate'],

    # Quit app-menu item.
    # Application MAY modify :QUIT for language.
    QUIT: [label: 'Quit'],
    quit: h0,
    quit!: [:QUIT, :quit, 'activate'],

    # Quit confirmation dialog.
    QUIT_URSURE: a0,
    quit_ursure: {add_label: 'Quit?'},
    quit_ursure!: [:QUIT_URSURE, :quit_ursure],

    # Quit Exception(raised by finalizer) message
    QUIT_EXCEPTION: a0,
    quit_exception: {set_message_type: :info},
    quit_exception!: [:QUIT_EXCEPTION, :quit_exception],

    # The app menu configuration.
    # The application MAY ONLY modify app_menu.add_menu_item
    # by removing un-wanted app menu items.
    # Note that you can reference the item.key,
    # see: Gtk3App::Widget::MenuItem < Such::MenuItem
    APP_MENU: a0,
    app_menu: {
      add_menu_item: [ :minime!, :fs!, :help!, :about!, :quit!  ],
    },
    # s0 tells AppMenu not to connect to any signal, otherwise it assumes "clicked".
    app_menu!: [:APP_MENU, :app_menu, s0],
  }
end
