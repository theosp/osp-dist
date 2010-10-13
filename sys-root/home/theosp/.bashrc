# If not running interactively or under vim, don't do anything
[ -z "$PS1" ] && [ -z "$UNDER_VIM" ] && return

# source locale conf
. ~/.bashrc-locale
# source alias definitions
. ~/.bashrc-aliases
# source exports definitions
. ~/.bashrc-exports

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

BASHRC_PWD="$(script_pwd)"

# script_pwd will be available later using bupler.script_pwd ()
# we delete it here for tidiness
unset -f script_pwd

cd "$BASHRC_PWD/../../.."
OSP_DIST_PWD="$(pwd -P)"
cd - > /dev/null

# source the Bupler lib base module
. "$OSP_DIST_PWD/bupler-lib/modules/bupler"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# appends to .bash_history instead of overwriting which is invaluable with 
# multiple terminals
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

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


# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# turn off the visual bell
if [ -x /usr/bin/xset ]; then
    xset b off
    xset b 0 0 0
fi

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

clear
