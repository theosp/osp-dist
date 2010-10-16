#!/bin/bash

# turn off the visual bell
if [ -x /usr/bin/xset ]; then
    xset b off
    xset b 0 0 0
fi

# vim:ft=bash:
