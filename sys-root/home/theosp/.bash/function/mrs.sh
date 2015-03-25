#!/bin/bash

mrs () {
    rs "$1" | grep -v ".meteor" | grep -v ".npm"
}

# vim:ft=bash:
