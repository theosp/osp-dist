#!/bin/bash

# Note: PWD stands here for physical working directory.
# Original from:
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-in/179231#179231

SCRIPT_PWD="${BASH_SOURCE[1]}"; # use index 0 to get this script's path and not the path for the script that sourced it
if([ -h "${SCRIPT_PWD}" ]) then
    while([ -h "${SCRIPT_PWD}" ]) do SCRIPT_PWD=`readlink "${SCRIPT_PWD}"`; done
fi

pushd . > /dev/null
cd `dirname ${SCRIPT_PWD}` > /dev/null
SCRIPT_PWD=`pwd`;
popd > /dev/null
