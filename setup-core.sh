#!/bin/bash

cd "$(dirname $0)"
./init_submodules.sh

. "$(dirname $0)/bupler-lib/modules/bupler"
SCRIPT_PWD="$(bupler.script_pwd 1)"

link () {
    local path="$1"
    local target="${path/\/home\/theosp/$HOME}"

    if [[ -e $target ]]
    then
        mv "$target" "$target-backup"
    fi

    ln -s "$SCRIPT_PWD/sys-root$path" "$target"
}

copy () {
    local path="$1"
    local target="${path/\/home\/theosp/$HOME}"

    cp "$SCRIPT_PWD/sys-root$path" "$target"
}

sudoCopy () {
    local path="$1"
    local target="${path/\/home\/theosp/$HOME}"

    sudo cp "$SCRIPT_PWD/sys-root$path" "$target"
}

# copy terminfo files
sudo mkdir -p /usr/share/terminfo/r/
sudoCopy /usr/share/terminfo/r/rxvt-256color
sudo mkdir -p /usr/share/terminfo/s/
sudoCopy /usr/share/terminfo/s/screen
sudoCopy /usr/share/terminfo/s/screen-256color
sudoCopy /usr/share/terminfo/s/screen-256color-bce
sudoCopy /usr/share/terminfo/s/screen-bce
sudoCopy /usr/share/terminfo/s/screen-s
sudoCopy /usr/share/terminfo/s/screen-w

link /home/theosp/.vim
link /home/theosp/.vimrc
link /home/theosp/.bash
link /home/theosp/.bash_profile
link /home/theosp/.bashrc
link /home/theosp/.bashrc-aliases
link /home/theosp/.bashrc-exports
link /home/theosp/.bashrc-locale
link /home/theosp/.screenrc

mkdir -p ~/.ssh # -p to avoid stderr if exists
if [[ -e ~/.ssh/authorized_keys ]]
then
    # create backup for ~/.ssh/authorized_keys before copy our
    mv ~/.ssh/authorized_keys "$HOME/.ssh/authorized_keys-`date +%Y-%m-%d-%k:%M`~"
fi
copy /home/theosp/.ssh/authorized_keys

sudo locale-gen he_IL.UTF-8
sudo locale-gen en_US.UTF-8

# Enable vim logging
sudo touch /var/log/vim
sudo chmod a+rw /var/log/vim

case "$(lsb_release -s -i)" in
    "Ubuntu")
        sudo aptitude install tree curl screen ipython ruby ruby-dev openjdk-6-jre
    ;;
esac
