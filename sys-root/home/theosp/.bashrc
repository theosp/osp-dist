# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -n $linuxDistPath ]; then
    export linuxDistPath=~/linux-dist/trunk
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# locale conf:
if [ -f ${linuxDistPath}/config/bash/.bashrc-locale ]; then
    . ${linuxDistPath}/config/bash/.bashrc-locale
fi

# Alias definitions.
if [ -f ${linuxDistPath}/config/bash/.bashrc-aliases ]; then
    . ${linuxDistPath}/config/bash/.bashrc-aliases
fi

# Exports definitions.
if [ -f ${linuxDistPath}/config/bash/.bashrc-exports ]; then
    . ${linuxDistPath}/config/bash/.bashrc-exports
fi

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

#PATH=${linuxDistPath}/bin:$PATH

export DJANGO_SETTINGS_MODULE=lobservers.settings

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

alias my_fbcli='fbcli --url razoss.fogbugz.com --user "daniel@razoss.com" --password d43567'

# General alias
alias l='ls'
alias lsl='ls -l'

# Git stuffs
g () {
    cat <<EOF
g - this legend
glom - Git pulL Origin Master
ghom - Git pusH Origin Master
gd   - git diff
gD   - git diff --cached
gdt  - git diff today
gl   - git log
gs   - git status
gc   - git commit
ga   - git add
EOF
}
alias glom='git pull origin master' # Git pulL Origin Master
alias ghom='git push origin master' # Git pusH Origin Master
alias gd='git diff' # Git diff
alias gD='git diff --cached' # Git diff --cached
alias gdt='git diff --since="9 hours"' # Git diff yesterday
alias gl='git log --pretty=oneline --graph'
alias gs='git status'
alias gc='git commit'
alias ga='git add'

# SSH stuffs
alias sa='ssh-add'

clear
