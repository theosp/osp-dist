#!/bin/bash

# Call $1 with the last two args swapped
call_command_last_two_args_swapped ()
{
    local command="$1"
    shift

    if (( ${#@} > 2 ))
    then
        "$command" "${@:1:$(( ${#@} - 2 ))}" "${@: -1:1}" "${@: -2:1}"
    else
        "$command" "${@: -1:1}" "${@: -2:1}"
    fi
}

# Reverse copy
rcp ()
{
    call_command_last_two_args_swapped cp "${@}"
}

# Reverse move
rmv ()
{
    call_command_last_two_args_swapped mv "${@}"
}

# vim:ft=bash:
