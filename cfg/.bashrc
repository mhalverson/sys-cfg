#I like git autocomplete, AND
#I have private things that I don't want checked in to a public git repo
for SRC_FILE in ~/git-completion.bash ~/.bashrc_private ~/.complete-hosts.sh
do
    if [ -f $SRC_FILE ]; then
        echo "sourcing $SRC_FILE"
        source $SRC_FILE
    fi
done

#I like a prompt with green stuff
export PS1='\[\e[1;32m\][\w] \$\[\e[0m\] '

#I like colored output of ls
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#I like using git diff in emacs-shell
export GIT_PAGER=/bin/cat

export PATH=$PATH:~/bin
export PATH=$PATH:~/.arcanist/arcanist/bin
export PATH=$PATH:/opt/vertica/bin

export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
alias gemacs=/Applications/Emacs.app/Contents/MacOS/Emacs
export ALTERNATIVE_EDITOR=gemacs
alias remacs=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient

alias h?="history | grep"
