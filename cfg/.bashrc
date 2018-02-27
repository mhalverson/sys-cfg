################################################################################
# Files to source at start
TO_SOURCE=(
    ~/.complete-hosts.sh
    ~/.git-prompt.sh
    ~/.bashrc_group_private
)
for SRC_FILE in "${TO_SOURCE[@]}"
do
    if [ -f $SRC_FILE ]; then
        echo "sourcing $SRC_FILE"
        source $SRC_FILE
    fi
done

################################################################################
# Set up autocompletion facilities early
if [ -f $(brew --prefix)/etc/bash_completion ] && ! shopt -oq posix; then
    . $(brew --prefix)/etc/bash_completion
fi

################################################################################
# Prompt strings
# see http://askubuntu.com/questions/111840/ps1-problem-messing-up-cli
function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

green=$(tput setaf 2)
reset=$(tput sgr0)
export PS1='${PIPESTATUS[@]}:(\[$green\]${timer_show}s\[$reset\]):\[$green\][\w] \$\[$reset\] '

################################################################################
# I like colored output
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

################################################################################
# PATH
mkdir -p ~/bin
export PATH=/usr/local/bin:$PATH:/usr/local/sbin:~/bin
export PATH=$PATH:~/.arcanist/arcanist/bin

################################################################################
# Editors
alias gemacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias remacs=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
# export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
# export ALTERNATIVE_EDITOR=gemacs
export EDITOR=vim
export ALTERNATIVE_EDITOR=vim


################################################################################
# Git
alias ga="git add"
alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias gco="git checkout"
alias grb="git rebase"

# Was having problems with 'unary operator expected' when using other
# bash completion facilities (complete -F _git_checkout gco) but learned
# that I should be going through __git_complete (as defined in
# git-completion.bash) instead. Yay!
# http://git.661346.n2.nabble.com/How-to-setup-bash-completion-for-alias-of-git-command-td7574816.html
__git_complete ga _git_add
__git_complete gs _git_status
__git_complete gb _git_branch
__git_complete gd _git_diff
__git_complete gco _git_checkout
__git_complete grb _git_rebase

################################################################################
# Miscellany
export PYTHONSTARTUP=$HOME/.pystartup
alias clear_hard="clear && printf '\e[3J'"
# ^see http://askubuntu.com/questions/25077/how-to-really-clear-the-terminal

################################################################################
# Session stuff
if [ "$SESSION" ]; then
    if [ ! -d ~/.session/$SESSION ]; then
        mkdir -p ~/.session/$SESSION
    fi
    export PATH=~/.session/$SESSION/bin:$PATH
    export HISTFILE=~/.session/$SESSION/bash_history
    export VSQL_HOME=~/.session/$SESSION

    if [ ! -f $VSQL_HOME/.vsqlrc ]; then
        ln -s ~/.vsqlrc $VSQL_HOME/.vsqlrc
    fi
    if [ -f ~/.session/$SESSION/bashrc ]; then
        source ~/.session/$SESSION/bashrc
    fi
fi

_complete_session() {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    session_list=`ls ~/.session/ | tr ' ' '\n'`
    COMPREPLY=( $(compgen -W "${session_list}" -- $cur))
    return 0
}
complete -F _complete_session session

################################################################################
# Dossiers
_complete_dossier() {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    dossier_list=`ls ~/dossier/ | tr ' ' '\n'`
    COMPREPLY=( $(compgen -W "${dossier_list}" -- $cur))
    return 0
}
complete -F _complete_dossier dossier

################################################################################
# notification
notify_me () {
    # brew install terminal-notifier
    # https://github.com/julienXX/terminal-notifier
    #
    # usage: cmd-that-takes-a-while ; notify_me done
    terminal-notifier -message "$*"
}

################################################################################
# go stuff
export GOPATH="$HOME/gocode"
export PATH="$PATH:$GOPATH/bin"

################################################################################
# haskell stuff
export PATH="$PATH:~/.cabal/bin"
docker-refresh() {
    docker-machine start default
    eval "$(docker-machine env default)"
}
alias stack='stack --docker-run-args="--interactive=false"'

################################################################################
# bash customizations - see bash manpage
export CDPATH=".:~"
export FIGNORE='.pyc:~'
export HISTCONTROL=ignorespace:erasedups
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
export IGNOREEOF=2
export PAGER=less
export HISTSIZE=100000

shopt -s histappend
shopt -s histreedit
shopt -s lithist
shopt -s no_empty_cmd_completion

################################################################################
# Completion for fab (Fabric)
function _fab_complete() {
    local cur
    if [ -f "fabfile.py" ]; then
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "$(fab -F short -l)" -- ${cur}) )
        return 0
    else
        # no fabfile.py found. Don't do anything.
        return 1
    fi
}
complete -o nospace -F _fab_complete fab

################################################################################
# Miscellany
export PYTHONSTARTUP=$HOME/.pystartup
alias clear_hard="clear && printf '\e[3J'"
# ^see http://askubuntu.com/questions/25077/how-to-really-clear-the-terminal

################################################################################
# Files to source at end
export HOSTFILE=~/.hostfile
PRIVATE_BASHRC=~/.bashrc_private
echo "sourcing $PRIVATE_BASHRC"
source "$PRIVATE_BASHRC"
