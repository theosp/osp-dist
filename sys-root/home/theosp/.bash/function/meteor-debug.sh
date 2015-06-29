#!/bin/bash

meteor-debug () {
    env NODE_OPTIONS='--debug' meteor "$@"
}

meteor-debug-port () {
    local port="$1"

    shift

    env NODE_OPTIONS="--debug=${port}" meteor "$@"
}

meteor-debug-brk () {
    env NODE_OPTIONS='--debug-brk' meteor "$@"
}

meteor-debug-brk-port () {
    local port="$1"

    shift

    env NODE_OPTIONS="--debug-brk=${port}" meteor "$@"
}

mrt-debug () {
    env NODE_OPTIONS='--debug' mrt "$@"
}

mrt-debug-port () {
    local port="$1"

    shift

    env NODE_OPTIONS="--debug=${port}" mrt "$@"
}

mrt-debug-brk () {
    env NODE_OPTIONS='--debug-brk' mrt "$@"
}

mrt-debug-brk-port () {
    local port="$1"

    shift

    env NODE_OPTIONS="--debug-brk=${port}" mrt "$@"
}

# vim:ft=bash:
