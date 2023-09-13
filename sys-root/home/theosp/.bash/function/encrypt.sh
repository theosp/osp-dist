#!/bin/bash

# https://gist.github.com/crazybyte/4142975

# 2023-09-14 Regarding the addition of -md md5 see:
# https://community.jamf.com/t5/jamf-pro/encrypted-openssl-aes-256-macos-monterey-cannot-be-decrypted-with/td-p/277416
# https://archive.is/wip/Fp59F

aesEnc () {
    openssl aes-256-cbc -md md5 -salt -a -e -in "$1" -out "$1.enc"
}

aesDec () {
    if [[ "$1" == "${1%%.enc}" ]]; then
        # If file doesn't end with .enc output as .dec
        openssl aes-256-cbc -md md5 -salt -a -d -in "$1" -out "$1.dec"
    else
        # If file ends with .enc output as original name without the .enc
        # suffix
        openssl aes-256-cbc -md md5 -salt -a -d -in "$1" -out "${1%%.enc}"
    fi
}

# vim:ft=bash:
