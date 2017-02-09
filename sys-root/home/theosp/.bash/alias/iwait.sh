#!/bin/bash

iwait () {
    if [[ -z "$1" ]]; then
        cat <<EOF

# iwait

## Usage example:

  $ iwait file-name/dir-name ./command-to-execute arg1 arg2...

## Usage example2, more than one command to execute:

  $ iwait file-name/dir-name /bin/bash -c './command-to-execute-2 arg1 arg2...; ./command-to-execute-1 arg1 arg2...; ...'

EOF

        return 1
    fi

    watched_path="$1" # Note, if a folder provided symbolic links under it are not traversed.

    shift # All the other arguments are considered the command to execute

    echo 
    echo ">>> Performing action for first time:"
    echo 

    "${@}"

    echo 
    echo ">>> Init inotifywait:"
    echo 

    # We use while without -m to avoid exit inotifywait from exit/stop watchin
    # the file when move_self happens (this is the way vim saves files)
    #
    # By running the while this way, we re-initializing inotify after every
    # event, this way we know for sure that in cases like move_self based
    # save the new file will be watched in the next itteration.
    while inotifywait -e moved_from -e moved_to -e move_self -e close_write -r "$watched_path"; do

        echo 
        echo 
        echo ">>> Action BEGIN"
        "${@}"
        echo ">>> Action DONE"
        echo 
        echo 

        # short sleep for case file was saved by moving temp file (in
        # which case it won't exist for few ms move_self case).
        sleep .1
    done
}
