#!/bin/bash

mrs () {
    lrs "$1" | grep -v ".meteor" | grep -v ".npm"
}

# vim:ft=bash:
