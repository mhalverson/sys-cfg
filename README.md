sys-cfg
=======

System config files, such as .bashrc, .emacs, .slate

Install the following:

    - dropbox
    - slate
    - karabiner https://pqrs.org/osx/karabiner/
    - vim plugin manager https://github.com/junegunn/vim-plug
    - flux
    - keepass
    - chrome
    - caffeine

Run the following scripts:

    $ ./scripts/init_git_repos.sh
    $ ./scripts/make_symlinks.sh

Then install manually:

    $ brew install git && brew install bash-completion
    # set up Karabiner keyboard remapper
    #   left_option -> left_alt
    #   caps_lock -> left_control
