# Do nothing, unless interactive mode, or the user explicitly tells us he wants
# to, or under vim
[ -z "$PS1" ] && [ -z "$UNDER_VIM" ] && [ -z "$BASHRC_INTERACTIVE_MODE_INIT" ] && return

# source script_pwd which is essential for bupler's init
. ~/.bash/function/script_pwd.sh

# Get this script physical path 
BASHRC_PWD="$(script_pwd)"

# Get the osp-dist package physical path
cd "$BASHRC_PWD/../../.."
OSP_DIST_PWD="$(pwd -P)"
cd - > /dev/null

# source the Bupler lib base module
. "$OSP_DIST_PWD/bupler-lib/modules/bupler"

# source locale conf
. ~/.bashrc-locale

# load aliases
for i in ~/.bash/alias/*
do
    . "$i"
done

# load functions
for i in ~/.bash/function/*
do
    . "$i"
done

# load programs configurations
for i in ~/.bash/config/*
do
    . "$i"
done

# load plugins
for i in ~/.bash/plugin/*
do
    . "$i/main.sh"
done

PATH+=":~/.bash/scripts/:~/node_modules/.bin/"

clear
