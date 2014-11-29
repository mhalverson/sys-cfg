#I like git autocomplete, AND
#I have private things that I don't want checked in to a public git repo
for SRC_FILE in ~/.git-completion.bash ~/.bashrc_private ~/.complete-hosts.sh /usr/local/opt/autoenv/activate.sh
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

export PATH=$PATH:~/bin
export PATH=$PATH:~/.arcanist/arcanist/bin
export PATH=$PATH:/opt/vertica/bin
export PATH=$PATH:$HOME/bin

export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
alias gemacs=/Applications/Emacs.app/Contents/MacOS/Emacs
export ALTERNATIVE_EDITOR=gemacs
alias remacs=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient

alias hgrep="history | grep"
alias cgrep='find . -name "*.clj" -print0 | xargs -0 grep'
alias rgrep='find . -name "*.rb" -print0 | xargs -0 grep'
alias pygrep='find . -name "*.py" -print0 | xargs -0 grep'

alias tunnel_v="ssh -L 5433:localhost:5433 vertica04-peak1 -fN"

#I like using git diff in emacs-shell
alias egit="GIT_PAGER=/bin/cat git"
