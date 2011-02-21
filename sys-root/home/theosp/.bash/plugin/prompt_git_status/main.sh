#!/bin/bash

# When under a git repository this plugin adds the bash prompt indicators about
# the repository status.
# 
# The status includes the current branch and colored circles that have the
# following meaning:
# Green: there are staged changes,
# Yellow: if there are unstaged changes
# Red: if there are new untracked-yet-unignored files
#
# The idea for this script came from:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt

bupler.import style
bupler.import git

prompt_command_git_status ()
{
    local result="\[$(style.fcolor 4)$(style.bold)\]$(git.current_branch)"
    local status=($(git.status))

    if (( ${status[1]} == 1 )) || (( ${status[2]} == 2 )) || (( ${status[3]} == 3 )) || (( ${status[4]} == 4 )) || (( ${status[5]} == 5 ))
    then
        #echo "staged changes"
        result+="\[$(style.fcolor 2)$(style.bold)\]●\[$(style.reset)\]"
    fi
    if (( ${status[6]} == 1 )) || (( ${status[7]} == 1 ))
    then
        #echo "unstaged changes"
        result+="\[$(style.fcolor 3)$(style.bold)\]●\[$(style.reset)\]"
    fi
    if (( ${status[0]} == 1 ))
    then
        #echo "untracked changes"
        result+="\[$(style.fcolor 1)$(style.bold)\]●\[$(style.reset)\]"
    fi

    echo "$result"
}

if [ "$TERM" != 'dumb' ] && [ -n "$BASH" ] && [ -n "$PS1" ]
then
    # The extra line after <<EOF is for cases where there is already
    # PROMPT_COMMAND that doesn't ends with ;
    PROMPT_COMMAND+="$(cat <<EOF

        if git.is_rep > /dev/null
        then
                export PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\W [\[\033[00m\]\$(prompt_command_git_status)\[\033[01;34m\]] \$ \[\033[00m\]"
        else
            if [ "\$(/usr/bin/whoami)" = 'root' ]
            then
                export PS1='\[\033[01;31m\]\h \[\033[01;34m\]\W \$ \[\033[00m\]'
            else
                export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
            fi
        fi
EOF
    )"
fi
# vim:ft=bash:
