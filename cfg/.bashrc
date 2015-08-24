################################################################################
# Files to source at start
TO_SOURCE=(
    ~/.complete-hosts.sh
    /usr/local/opt/autoenv/activate.sh
    ~/.git-prompt.sh
    ~/Code/u/tools/resources/completion.sh
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
# Prompt strings
# see http://askubuntu.com/questions/111840/ps1-problem-messing-up-cli
green=$(tput setaf 2)
reset=$(tput sgr0)
export PS1='${PIPESTATUS[@]}::\[$green\][\w] \$\[$reset\] '

################################################################################
# I like colored output of ls
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

################################################################################
# PATH
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/sbin
mkdir -p ~/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.arcanist/arcanist/bin
export PATH=$PATH:~/Downloads/opt/vertica/bin
export PATH=$PATH:~/Code/u/tools/bin
export PATH=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home/bin:$PATH

################################################################################
# Editors
export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
alias gemacs=/Applications/Emacs.app/Contents/MacOS/Emacs
export ALTERNATIVE_EDITOR=gemacs
alias remacs=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient

################################################################################
# ssh tunneling
ADHOC=adhoc04-sjc1
alias adhoc="ssh $ADHOC"

tunnel () {
    PORT=$1; shift
    ssh -L $PORT:localhost:$PORT $ADHOC -N
}

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
# bash customizations - see bash manpage
export CDPATH=.:~:~/Code/u/
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
if [ -f $(brew --prefix)/etc/bash_completion ] && ! shopt -oq posix; then
    . $(brew --prefix)/etc/bash_completion
    complete -o nospace -F _fab_complete fab
fi

################################################################################
# Miscellany
export PYTHONSTARTUP=$HOME/.pystartup
alias clear_hard="clear && printf '\e[3J'"
# ^see http://askubuntu.com/questions/25077/how-to-really-clear-the-terminal

#Remember this:
# remacs $(find jobs/vertica/static -type f)
# to repeat last command: C-x z [z+]


################################################################################
# Files to source at end
export HOSTFILE=~/.hostfile
PRIVATE_BASHRC=~/.bashrc_private
echo "sourcing $PRIVATE_BASHRC"
source "$PRIVATE_BASHRC"
