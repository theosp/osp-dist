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
