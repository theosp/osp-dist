#!/bin/bash

alias s='ssh'

# ssh stuffs
alias sa='ssh-add'

# ssh keygen
sk ()
{
    ssh-keygen -t rsa -C "$1"
}

# vim:ft=bash:
