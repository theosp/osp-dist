#!/bin/bash

command_dry_run="rsync -n -ai --delete"
command="rsync -ai --delete"

alias rsync-my-preferences-dry-run="$command_dry_run"

rsync-my-preferences () {
    # Requre at least two arguments
    if [[ $# -lt 2 ]]
    then
        echo "Usage: rsync-my-preferences <source> <destination>"
        return 1
    fi

    # Check whether the first argument is a directory
    if [[ ! -d $1 ]]
    then
        echo "Frobidden: The first argument must be a directory"
        return 1
    fi

    # Check whether the first argument ends with a slash, if it isn't - reject the request
    # let the user know that only directories can be synced
    if [[ ! $1 =~ /$ ]]
    then
        echo "Frobidden: The first argument must end with a /"
        return 1
    fi

    echo "Note that for dry-run you can call:"
    echo ""
    echo "$ rsync-my-preferences-dry-run $@"
    echo ""

    echo "This will run the command: $"
    echo 
    echo "$ $command $@"
    echo


    read -p "Are you sure you want to proceed? (y/n) " -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Aborting."
        return 1
    fi

    echo "Running in 3 seconds..."
    sleep 3
    $command "$@"
}

# vim:ft=bash:
