# If not running interactively or under vim, don't do anything
[ -z "$PS1" ] && [ -z "$UNDER_VIM" ] && return

# source locale conf
. ~/.bashrc-locale

# The following is a clone of the bupler lib's bupler.script_pwd function as it
# was in bupler-lib commit: 01e255794dbcd3d557631e3cea8b414e5be95e89, we define
# it here since the osp-dist creates symbolic link from it's .bashrc to
# ~/.bashrc, so in order to make it possible to get the osp-dist's physical path
# in this script, we need to be able to tell this script physical pwd
script_pwd ()
{
    # credit: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-in/179231#179231
    local physical=0
    if [[ -n "$1" ]] && (( $1 == 1 ))
    then
        physical=1
    fi
# load aliases
for i in ~/.bash/alias/*
do
    . "$i"
done

    local SCRIPT_PWD="${BASH_SOURCE[1]}"
    if [ -h "${SCRIPT_PWD}" ] 
    then
        while [ -h "${SCRIPT_PWD}" ]
        do
            SCRIPT_PWD=`readlink "${SCRIPT_PWD}"`
        done
    fi

    pushd . > /dev/null
    cd `dirname ${SCRIPT_PWD}` > /dev/null
    if (( $physical == 1 ))
    then
        # print physical path
        SCRIPT_PWD=`pwd -P`
    else
        SCRIPT_PWD=`pwd`
    fi
    popd > /dev/null

    echo -n $SCRIPT_PWD

    return 0
}

# load programs configurations
for i in ~/.bash/config/*
do
    . "$i"
done

BASHRC_PWD="$(script_pwd)"

# script_pwd will be available later using bupler.script_pwd ()
# we delete it here for tidiness
unset -f script_pwd

cd "$BASHRC_PWD/../../.."
OSP_DIST_PWD="$(pwd -P)"
cd - > /dev/null

# source the Bupler lib base module
. "$OSP_DIST_PWD/bupler-lib/modules/bupler"


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_colored_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$TERM" != 'dumb' ] && [ -n "$BASH" ] && [ -n "$PS1" ]
then
    if [ `/usr/bin/whoami` = 'root' ]
    then
            export PS1='\[\033[01;31m\]\h \[\033[01;34m\]\W \$ \[\033[00m\]'
    else
            export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
    fi
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
    *)
    ;;
esac


# When under a git repository this function adds the bash prompt indicators about
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
    local result="$(style.fcolor 4)$(style.bold)$(git.current_branch)"
    local status=($(git.status))

    if (( ${status[1]} == 1 )) || (( ${status[2]} == 2 )) || (( ${status[3]} == 3 )) || (( ${status[4]} == 4 )) || (( ${status[5]} == 5 ))
    then
        #echo "staged changes"
        result+="$(style.fcolor 2)$(style.bold)●$(style.reset)"
    fi
    if (( ${status[6]} == 1 )) || (( ${status[7]} == 1 ))
    then
        #echo "unstaged changes"
        result+="$(style.fcolor 3)$(style.bold)●$(style.reset)"
    fi
    if (( ${status[0]} == 1 ))
    then
        #echo "untracked changes"
        result+="$(style.fcolor 1)$(style.bold)●$(style.reset)"
    fi

    echo "$result"
}

export original_ps="$PS1"
PROMPT_COMMAND+="$(cat <<EOF

    if git.is_rep > /dev/null
    then
        export PS1="\$(style.fcolor 2)\$(style.bold)\u@\h \$(style.fcolor 4)\$(style.bold)\W [\$(style.reset)\$(prompt_command_git_status)\$(style.fcolor 4)\$(style.bold)] \$ \$(style.reset)"
    else
        export PS1="\$original_ps"
    fi
EOF
)"

clear
