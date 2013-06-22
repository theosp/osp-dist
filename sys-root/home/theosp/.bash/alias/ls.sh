#!/bin/bash

if (( 0 == $(uname -a | grep Mac | wc -l) )); then
    alias ls='ls --color=auto'
fi

alias l='ls'
alias lsl='ls -l'

# vim:ft=bash:
