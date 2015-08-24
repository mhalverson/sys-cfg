#!/bin/bash

SCRIPTS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
# peculiarity on mac os x -- the above echoes twice
SCRIPTS_DIR=$(echo "$SCRIPTS_DIR" | tr -s "[:space:]" "\n" | tail -n 1)
PROJECT_DIR=$(dirname "$SCRIPTS_DIR")
CFG_DIR="${PROJECT_DIR}/cfg"

########################################
# Make the cfg files in $HOME symlinks to the git-controlled versions here.
########################################
CFG_FILES=(
    .bashrc
    .complete-hosts.sh
    .emacs
    .emacs.d/column-marker.el
    .emacs.d/exec-path-from-shell.el
    .git-completion.bash
    .lein/profiles.clj
    .slate
    .vsqlrc
 )
for CFG_FILE in "${CFG_FILES[@]}"
do
    LINK_PATH="${HOME}/${CFG_FILE}"
    CFG_PATH="${CFG_DIR}/${CFG_FILE}"
    if [ -L "${LINK_PATH}" ]; then
        LINK_TARGET=$(readlink "${LINK_PATH}")
        if [ "${LINK_TARGET}" = "${CFG_PATH}" ]; then
            echo "Already a symlink from ${LINK_PATH} to ${CFG_PATH}"
            continue;
        fi
    fi

    SHOULD_CREATE_SYMLINK=true
    if [ -f "${LINK_PATH}" ]; then
        echo "Found existing version of ${LINK_PATH}..."
        echo "Overwrite existing version of ${LINK_PATH} to be a symlink? (y/N)"
        read -n 1
        echo
        case $REPLY in
                y|Y) SHOULD_CREATE_SYMLINK=true; rm "${LINK_PATH}"; break;;
                n|N|*) SHOULD_CREATE_SYMLINK=false; break;;
        esac
    fi

    if $SHOULD_CREATE_SYMLINK; then
        echo "Creating ${LINK_PATH} as symlink to ${CFG_PATH}"
        ln -s "${CFG_PATH}" "${LINK_PATH}"
    fi
done

########################################
# Make .bash_profile and .profile be symlinks to .bashrc.
# Don't ask, just do it. I hate the proliferation of bash init files,
#   and this is my environment :)
########################################
for BASH_INIT_FILE in .profile #.bash_profile
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
