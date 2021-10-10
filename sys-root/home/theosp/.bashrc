#/usr/bin/env bash

#############################################
# Potential issues on mac
#
# 1. Make sure you are using the right bash version, https://johndjameson.com/blog/updating-your-shell-with-homebrew/
#    $ bash --version # make sure v4
#    $ which bash
#    $ sudo -s
#    $ # assuming /usr/local/bin/bash is what got returned by `which bash`
#    $ echo /usr/local/bin/bash >> /etc/shells
#    $ chsh -s /usr/local/bin/bash
#    $ # do the same for your user as well
# 2. Locale issue
#    $ locale -a # will print all available locales, make sure you are using
#    available locale
#
#############################################

# Do nothing, unless interactive mode, or the user explicitly tells us he wants
# to, or under vim
[ -z "$PS1" ] && [ -z "$UNDER_VIM" ] && [ -z "$BASHRC_INTERACTIVE_MODE_INIT" ] && return

# source script_pwd which is essential for bupler's init
. ~/.bash/function/script_pwd.sh

# Get this script physical path 
BASHRC_PWD="$(script_pwd)"

# Get the osp-dist package physical path
cd "$BASHRC_PWD/../../.."
OSP_DIST_PWD="$(pwd -P)"
cd - > /dev/null

# source the Bupler lib base module
. "$OSP_DIST_PWD/bupler-lib/modules/bupler"

# source locale conf
. ~/.bashrc-locale

# load aliases
for i in ~/.bash/alias/*
do
    . "$i"
done

# load bash-helpers
for i in ~/.bash/bash-helpers/functions/*
do
    . "$i"
done

# load functions
for i in ~/.bash/function/*
do
    . "$i"
done

# load programs configurations
for i in ~/.bash/config/*
do
    . "$i"
done

# load plugins
for i in ~/.bash/plugin/*
do
    . "$i/main.sh"
done

PATH+=":~/.bash/scripts/:~/node_modules/.bin/"

clear
