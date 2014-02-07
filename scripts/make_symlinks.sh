#!/bin/bash

DIR_OF_THIS_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_WITH_SCRIPTS_STRIPPED=`echo "$DIR_OF_THIS_SCRIPT" | awk '{gsub("/scripts/?$", "");print}'`
CFG_DIR=$DIR_WITH_SCRIPTS_STRIPPED/cfg

########################################
# Make the cfg files in ~ be symlinks to the git-controlled versions here.
########################################
CFG_FILES=(
    .bashrc
    .emacs
    .slate
    .emacs.d/column-marker.el
    .lein/profiles.clj
    complete-hosts.sh
 )
for CFG_FILE in "${CFG_FILES[@]}"
do
    if [ -L ~/$CFG_FILE ] && [ `readlink ~/$CFG_FILE` == "$CFG_DIR/$CFG_FILE" ]; then
        echo "Already a symlink from ~/$CFG_FILE to $CFG_DIR/$CFG_FILE"
        continue;
    fi

    SHOULD_CREATE_SYMLINK=true
    if [ -f ~/$CFG_FILE ]; then
        echo "Found existing version of ~/$CFG_FILE..."
        echo "Overwrite existing version of ~/$CFG_FILE to be a symlink?"
        select yn in "Yes (1)" "No (2)"; do
            case $yn in
                [Yy]* ) SHOULD_CREATE_SYMLINK=true; rm ~/$CFG_FILE; break;;
                [Nn]* ) SHOULD_CREATE_SYMLINK=false; break;;
            esac
        done
    fi

    if $SHOULD_CREATE_SYMLINK; then
        echo "Creating ~/$CFG_FILE as symlink to the git-controlled version"
        ln -s $CFG_DIR/$CFG_FILE ~/$CFG_FILE
    fi
done

########################################
# Make .bash_profile and .profile be symlinks to .bashrc.
# Don't ask, just do it. I hate the proliferation of bash init files,
#   and this is my environment :)
########################################
for BASH_INIT_FILE in .bash_profile .profile
do
    if [ -L ~/$BASH_INIT_FILE ] && [ `readlink ~/$BASH_INIT_FILE` == ".bashrc" ]; then
        echo "Already a symlink from ~/$BASH_INIT_FILE to .bashrc"
        # Nothing to do -- it both exists AND is a symlink to the right thing
        continue;
    fi
    if [ -f ~/$BASH_INIT_FILE ]; then
        echo "Found file ~/$BASH_INIT_FILE, but it's not a symlink to .bashrc... running rm ~/$BASH_INIT_FILE"
        rm ~/$BASH_INIT_FILE
    fi
    echo "Creating a symlink from ~/$BASH_INIT_FILE to .bashrc"
    ln -s .bashrc ~/$BASH_INIT_FILE
done
