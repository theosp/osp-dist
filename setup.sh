#!/bin/bash

source `dirname $0`/setup/script_path.sh # load $SCRIPT_PWD
source $SCRIPT_PWD/setup/release_name.sh # load the release_name function

shopt -s extglob
files_to_copy=( )

# linking is better than copying and should be used where possible.
# linked file automatically "updated" in all the other servers with `svn
# update` without the need to rerun this script.
# it also makes it much easier to commit changes to the main repository, since
# it only require `svn ci`.
files_to_link=(
    $scriptDirname/sys-root/home/osp/.!(.|)
)
shopt -u extglob

for file in ${files_to_link[@]}
do
    # determine the path for the link
    target=${file#$scriptDirname}
    # replace /home/osp with the user's home dir
    target=${target/\/home\/osp/~}
    if release_name $target
    then
        ln -s $file $target
    fi
done

#chmod +x system-insall-linux-dist.sh
#exec su -c ./system-insall-linux-dist.sh
