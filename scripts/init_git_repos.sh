#!/bin/bash

DIR_TO_PUT_GIT_REPOS_IN="$HOME/Code/"
REPOS=(
    https://github.com/purcell/exec-path-from-shell.git
    https://github.com/jonase/kibit.git
    https://github.com/frobware/cmd-key-happy.git
)

if [ ! -d "$DIR_TO_PUT_GIT_REPOS_IN" ]; then
    echo "Was going to clone git repos into directory $DIR_TO_PUT_GIT_REPOS_IN, but it doesn't exist."
    echo "Create that directory, or change where the repos should be copied to, then run this script again."
    exit 0;
fi

cd "$DIR_TO_PUT_GIT_REPOS_IN"
for REPO in "${REPOS[@]}"
do
    #check if repo exists -- if exists, pull, otherwise, clone
    git clone $REPO
done


#then modify .emacs to have exec-path-from-shell
