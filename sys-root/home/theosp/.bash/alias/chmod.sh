#!/bin/bash

add_chmod_alias ()
{
    local users="$1"
    local op="$2"
    local mods="$3"

    if [[ "$op" == '+' ]]
    then
        local alias_op=""
    else
        local alias_op="r"
    fi

    alias c$alias_op$users$mods="chmod $users$op$mods"
}

for op in '+' '-'
do
    for users in u g o ug go uo a
    do
        for mods in r w x rw rx wx rwx
        do
            add_chmod_alias $users $op $mods
        done
    done
done

unset -f add_chmod_alias

# vim:ft=bash:
