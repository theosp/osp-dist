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

    echo ""
    echo "Running the dry-run... $ rsync-my-preferences-dry-run $@"
    echo ">>> The dry-run has a total output of"$(style.info)$(rsync-my-preferences-dry-run "$@" | wc -l)$(style.reset)" lines, do you want to see them?"
    echo ""

    read -p "Show the dry-run output? (Y/n) " -n 1 -r
    if [[ ! "$REPLY" =~ ^[Nn]$ ]]
    then
        echo ""
        echo ">>> Running the dry-run:"
        echo ""
        rsync-my-preferences-dry-run "$@"
        echo ""
    fi

    echo 
    echo "If you proceed the following command will run: "
    echo 
    echo "$ $command $@"
    echo

    read -p "Are you sure you want to proceed? (y/N) " -n 1 -r
    if [[ ! "$REPLY" =~ ^[Yy]$ ]]
    then
        echo "Aborting."
        return 1
    fi

    echo
    echo "Running in 3 seconds..."
    sleep 3
    $command "$@"
}

# vim:ft=bash:
