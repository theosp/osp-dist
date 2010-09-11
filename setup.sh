#!/bin/bash

source `dirname $0`/setup/script_path.sh # load $SCRIPT_PWD

link () {
    local path="$1"

    if [[ ! -e $path ]]
    then
        ln -s $SCRIPT_PWD'/sys-root'$path ${path/\/home\/theosp/$HOME}
    fi
}

copy () {
    local path="$1"

    cp $SCRIPT_PWD'/sys-root'$path $path
}

sudoCopy () {
    local path="$1"

    sudo cp $SCRIPT_PWD'/sys-root'$path $path
}

sudo mkdir -p /usr/share/terminfo/r/
sudoCopy /usr/share/terminfo/r/rxvt-256color

link /home/theosp/.fluxbox
link /home/theosp/.vim
link /home/theosp/.vimrc
link /home/theosp/.bash_profile
link /home/theosp/.bashrc
link /home/theosp/.bashrc-aliases
link /home/theosp/.bashrc-exports
link /home/theosp/.bashrc-locale
link /home/theosp/.screenrc
link /home/theosp/.Xdefaults

sudo mkdir -p /usr/share/images/wallpapers/
sudoCopy /usr/share/images/wallpapers/light-fish_1920X1200.jpg
