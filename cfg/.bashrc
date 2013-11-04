#I like git autocomplete
source ~/git-completion.bash

#I have private things that I don't want checked in to a public git repo
if [ -f ~/.bashrc_private ]; then
    source ~/.bashrc_private
fi

#I like a simple prompt
export PS1="\w > "

#I like colored output of ls
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH=$PATH:~/bin

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PATH=$PATH:/Users/mhalverson/.arcanist/arcanist/bin

export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
alias gemacs=/Applications/Emacs.app/Contents/MacOS/Emacs
export ALTERNATIVE_EDITOR=gemacs
alias remacs=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient

alias h?="history | grep"
