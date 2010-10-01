#!/bin/bash

. "$(dirname $0)/bupler-lib/modules/bupler"
SCRIPT_PWD="$(bupler.script_pwd 1)"

link () {
    local path="$1"
    local target="${path/\/home\/theosp/$HOME}"

    if [[ ! -e $target ]]
    then
        ln -s "$SCRIPT_PWD/sys-root$path" "$target"
    fi
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

case "$(lsb_release -s -i)" in
    "Ubuntu")
        sudo aptitude install git-cola fluxbox eterm kdiff3
        # we need eterm since fluxbox uses its background setter
    ;;
esac

link /home/theosp/.fluxbox
link /home/theosp/.Xdefaults

sudo mkdir -p /usr/share/images/wallpapers/
sudoCopy /usr/share/images/wallpapers/light-fish_1920X1200.jpg
