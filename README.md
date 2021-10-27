sys-cfg
=======

System config files, such as .bashrc, .emacs, .slate

Install the following:

    - dropbox
    - slate
    - karabiner https://pqrs.org/osx/karabiner/
    - vim plugin manager https://github.com/junegunn/vim-plug
    - flux
    - keepassX
    - chrome
    - caffeine
    - brew

Run the following scripts:

    $ ./scripts/make_symlinks.sh

Then install manually:

    $ brew install git && brew install bash-completion
    # set up Karabiner keyboard remapper
    #   caps_lock -> left_control
    #   left_command -> left_alt
    #   left_option -> left_command
    # set up Terminal preferences:
    #   set default Profile of Pro, have the Shell
    #   exit the window on closure
