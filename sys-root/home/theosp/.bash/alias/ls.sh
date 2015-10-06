#!/bin/bash

if [ "$(uname -s)" != "Darwin" ]; then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi

alias l='ls'
alias lsl='ls -l'

# vim:ft=bash:
