# This script supplies the release_name function.
# release_name gets path and works interactively with the user to release it, (if
# it isn't of course), by deleting, renaming or backuping it

# if fixed_release_name_action holds eligible action key, it'll be used instead
# of asking the user to choose one.
fixed_release_name_action=""

# The following array defines the available actions and their properties.
# Each $elements_per_action elements in it defines one action.
# The meaning of each action's element by its position is as follow:
#     * Single char that identify the action for getopts.
#     * Human readable action name.
#     * Boolian that determines whether the user can choose to perform the action on all the
#       files that will need release 1 or not 0.
#     * Boolian that determines whether we will ask the user to confirm the
#       execution 1 or not 0.
#     * number [1-6] that determines the types of file 
elements_per_action=5
actions=(
    # "action_char" "action name" (bool)"all_possible" (bool)"needs approval" (bool)"required input"
    # 1 means true 0 false
    # "all_possible" is set to 1 the user can choose to perform that action
    # on all the files that has to be released.
    "b" "backup" 1 0
    "d" "diff" 0 0
    "p" "print" 0 0
    # The print command uses the enviromental $PAGER if it set otherwise it
    # uses less
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

function _exec {
    # Executes the command after the positional var that holds --, if it was
    # called with -v it also prints the command first.

    # v - verbosity
    while getopts v o
    do  case "$o" in
        "v" )  local verbose="yes";; # if the function was called with the -v option set local var "verbose"
        esac
    done

    for param in "$@"
    do
        if [[ "$param" = '--' ]]
        then
            shift
            break
        fi
        shift
    done

    # execute
    "$@"

    if [[ -n "$verbose" ]]
    then
        echo '    (log)$ '"$@"
    fi
}

function release_name {
    # v - verbosity
    # s - source (optional), the path to the name we want to mv to target (will be used for diffs).
    # t - target, the path to the name we want to release.
    while getopts vs:t: o
    do  case "$o" in
        "v" )  local verbose="yes";; # if the function was called with the -v option set local var "verbose"
        "s" )  local source=${OPTARG};;
        "t" )  local target=${OPTARG};;
        esac
    done

    # If the target path isn't free
    # If the function managed to release the name it should return 0 otherwise
    # it returns 1
    while [ -e "$target" ]
    do
        echo "$target (`file "$target"`) already exists"

        local available_actions="s"
        local action

        if [ -d "$target" ]
        then
            # Actions available for dirs
            available_actions+="bx"
        else
            # Actions for regular files
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
        
        action=${action:0:1} # The rest doesn't interest us anymore

        local command
        case $action in
            'b' ) # backup
                    local backup_file=$target.bak-`date +%s`
                    # the date is added to avoid the possibility of overriding
                    # previous backup

                    command=('mv' $target $backup_file)
                    _exec "${a:+"-v"}" '--' "${command[@]}" # exec the command pass -v for verbose mode.
            ;;
            'd' ) # diff
            ;;
            'p' ) # print
                    pager=${PAGER:-"less"}
                    local print_sym_link="n"

                    if [ -L "$target" ]
                    then
                        echo "Symbolic link $target -> `readlink "$target"`, still want to print it? [y/N]"
                        read print_sym_link
                    fi

                    if [ ! -L "$target" ] || [ "$print_sym_link" = "y" ]
                    then
                        command=($pager $target)
                        _exec "${a:+"-v"}" '--' "${command[@]}" # exec the command pass -v for verbose mode.
                    fi
            ;;
            'r' ) # remove file

            ;;
            's' ) # skip

            ;;
            'x' ) # remove directory

            ;;
        esac
    done

    return 0
}

release_name -v -t ~/example.txt
