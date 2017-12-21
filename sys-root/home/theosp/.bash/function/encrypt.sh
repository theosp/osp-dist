#!/bin/bash

# https://gist.github.com/crazybyte/4142975

aesEnc () {
    openssl aes-256-cbc -salt -a -e -in "$1" -out "$1.enc"
}

aesDec () {
    if [[ "$1" == "${1%%.enc}" ]]; then
        # If file doesn't end with .enc output as .dec
        openssl aes-256-cbc -salt -a -d -in "$1" -out "$1.dec"
    else
        # If file ends with .enc output as original name without the .enc
        # suffix
        openssl aes-256-cbc -salt -a -d -in "$1" -out "${1%%.enc}"
    fi
}

# vim:ft=bash:
