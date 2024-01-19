#!/bin/bash

alias find-delete-ds-store='find . -name '.DS_Store' -type f -delete' 

# A function that prints for each of the folders in the current cwd the number of files in its entire folder tree
find-list-files-count-and-size() {
    echo -e "Folder\t\t\tSize\t\tFiles"
    for file in *; do
        if [ -d "$file" ]; then
            du_result_arr=( $(du -sh "$file") )
            echo $file$'\t\t'${du_result_arr[0]}$'\t\t'$(find "$file" -type f | wc -l)
        fi
    done
}

# vim:ft=bash:
