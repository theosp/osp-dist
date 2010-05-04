# This script supplies the release_name function.
# release_name gets path ($1) and work interactively with the user to release it, (if
# it isn't of course), by deleting, renaming or backuping it

# if fixed_release_name_action holds eligible action key, it'll be used instead
# of asking the user to choose one.
fixed_release_name_action=""

actions=(
    # "action_char" "action name" "all_possible" "needs approval"
    # if "all_possible" is set to 1 the user can choose to perform that action
    # on all the files that has to be released.
    "b" "backup" 1 0
    "d" "diff" 0 0
    "p" "print" 0 0
    "r" "remove file" 0 1
    "s" "skip" 1 1
    "x" "remove directory (recursive)" 0 1
)

function _get_action_name {
    # Gets action_char ($1) and returns its name
    local i

    for ((i=0; i<${#actions[@]}; i=i+4))
    do
        if [[ ${actions[$i]} = $1 ]]
        then
            echo -n ${actions[$(( $i + 1 ))]}
            return 0
        fi
    done
    return 1
}

function _fixed_ok {
    # Gets action_char ($1) and returns 0 if it can be used as the fixed_release_name_action
    # example:
    # if `fixed_ok 's'`
    # then
    #     echo 1;
    # fi
    local i

    for ((i=0; i<${#actions[@]}; i=i+4))
    do
        if [[ ${actions[$i]} = $1 ]]
        then
            if (( ${actions[$(( $i + 2 ))]} != 0 ))
            then
                return 0 # o.k.
            else
                return 1
            fi
        fi
    done
}

function release_name {
    # If the path supplied at ($1) isn't free
    # If the function managed to release the name it should return 0 otherwise
    # it returns 1
    while [ -e "$1" ]
    do
        echo "$1 (`file "$1"`) already exists"

        local available_actions="s"
        local action

        if [ -d "$1" ]
        then
            # Actions available for dirs
            available_actions+="bx"
        else
            available_actions+="pdbr"
        fi

        # If $fixed_release_name_action is empty or it isn't one of the
        # available actions
        if [[ -z "$fixed_release_name_action" || "$available_actions" = *$fixed_release_name_action* ]]
        then
            local i

            for ((i=0; i<${#available_actions}; i++))
            do
                action_char=${available_actions:$i:1}
                echo -n $action_char" "
                _get_action_name $action_char
                echo
            done

            for ((i=0; i<${#available_actions}; i++))
            do
                action_char=${available_actions:$i:1}
                # print the actions the user can set as the fixed actions
                if _fixed_ok $action_char 
                then
                    echo -n $action_char"a "
                    _get_action_name $action_char
                    echo -n ' all'
                    echo
                fi 
            done

            action="#" # "#" is for char for sure isn't in $available_actions
            # While the user didn't choose eligible action
            while [[ ! "$available_actions" = *${action:0:1}* ]]
            do
                echo -n "Choose action: "
                read -r action
            done

            if [[ ${action: -1} == 'a' ]]
            then
                if _fixed_ok ${action:0:1}
                then
                    fixed_release_name_action=${action:0:1}
                else
                    echo -n "Cant use "
                    _get_action_name ${action:0:1}
                    echo -n " as the fixed action... Using only for this case."
                fi
            fi
        else
            action=$fixed_release_name_action
        fi

        # If there is another chars they are not interest us anymore
        action=${action:0:1}

        case $action in
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

release_name ~/example.txt
