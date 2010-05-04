# This script supplies the release_name function that gets path in its first
# positional variable and work interactively with the user to release it, (if
# it exists), either by deleting it or by moving it to new name (backup it)

# if fixed_release_name_action holds eligible action key, it'll be used instead
# of asking the user to choose one.
fixed_release_name_action=""
function release_name {
    # If the path supplied at ($1), 
    while [ -e $1 ]
    do
        local action

        if [[ $fixed_release_name_action == '' ]]
        then
            echo "$1 (`file "$1"`) already exists"
            echo "what do you want to do?"
            echo "[p]rint it"
            echo "[b]ackup it (default), [d]elete it, [s]kip"
            echo "[ba] - backup always, [da] - delete always, [sa] - skip always"

            read action

            # set fixed action for all files need to be released.
            if [[ ${action: -1} == 'a' && 'bds' =~ ${action:0:1} ]]
            then
                fixed_release_name_action=${action:0:1}
            fi
        else
            action=$fixed_release_name_action
        fi

        case ${action:0:1} in
            'p' )   local print_sym_link="n"

                    if [ -L "$1" ]
                    then
                        echo $1 is a symbolic link to `readlink "$1"`, do you want to print it? [y/N]
                        read print_sym_link
                    fi

                    if [ ! -L "$1" ] || [ "$print_sym_link" = "y" ]
                    then
                        less $1
                    fi

                    ;;
            'b' )   local backup_file=$1.bak-`date +%s`

                    mv $1 $backup_file
                    echo $1 moved to $backup_file

                    ;;
            'd' )   rm $1

                    echo $1 removed
                    ;;
            's' )   echo skipping $1
                    return 1
                    ;;
        esac
    done

    return 0
}
