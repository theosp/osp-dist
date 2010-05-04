#!/bin/bash

source `dirname $0`/setup/script_path.sh # load $SCRIPT_PWD
source $SCRIPT_PWD/setup/release_name.sh # load the release_name function

shopt -s extglob
files_to_copy=( )

# linking is better than copying and should be used where possible.
# linked file "updates" automatically after pulling new versions, and simple pull share it with others.
files_to_link=(
    # This glob picks all the files from the home dir that begins with . except
    # of . and ..
    $scriptDirname/sys-root/home/theosp/.!(.|) 
)
shopt -u extglob

for file in ${files_to_link[@]}
do
    # determine the path for the link
    target=${file#$scriptDirname}
    # replace /home/osp with the user's home dir
    target=${target/\/home\/theosp/~}
    if release_name $target
    then
        ln -s $file $target
    fi
done

#chmod +x system-insall-linux-dist.sh
#exec su -c ./system-insall-linux-dist.sh
