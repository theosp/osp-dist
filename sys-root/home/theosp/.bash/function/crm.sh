#!/bin/bash

_conditional_remove () {
    local a
    echo "Remvoe $1? [y|n]"

    read a
    if [[ "$a" == y ]]; then
        rm "$1"
        echo "$1 removed"
    fi
}

crm () {
    local i a b

    for i in "${@}"; do
        echo "--------------------$i---------------------"

        cat "$i"

        echo "------------------EOF-$i--------------------"
        echo $"Remove $i? [y]es [n]o [o]pen with other [q]uit"

        echo "$i"
        read a
        if [[ "$a" == y ]]; then
            rm "$i"
            echo "$i removed"
        elif [[ "$a" == o ]]; then
            echo "How would you like to open this file? [l]ibreoffice [c]rome [g]thumb [m]player [e]vince"

            read b

            if [[ "$b" == l ]]; then
                libreoffice "$i"
                _conditional_remove "$i"
            elif [[ "$b" == c ]]; then
                google-chrome "$i"
                _conditional_remove "$i"
            elif [[ "$b" == g ]]; then
                gthumb "$i"
                _conditional_remove "$i"
            elif [[ "$b" == e ]]; then
                evince "$i"
                _conditional_remove "$i"
            elif [[ "$b" == m ]]; then
                mplayer "$i"
                _conditional_remove "$i"
            else
                echo "Error: unknown option, skipping"
            fi
        elif [[ "$a" == q ]]; then
            return 0
        fi
    done
}

# vim:ft=bash:
