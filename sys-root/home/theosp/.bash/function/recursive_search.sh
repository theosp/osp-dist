#!/bin/bash

# Recursive search string in path's files
# rs(needle, path=".")
rs () {
   local needle="$1"
   local path="${2:-.}"

   find "$path" -type f -exec grep -Hn "$1" {} \;
}

# Limited recursive search, drops lines that exceeds given lenght
lrs () {
   local needle="$1"
   local max_length="${LRS_MAX_LENGHT:-"$2"}"
   local max_length="${max_length:-"350"}"
   local path="${3:-.}"

   rs "$needle" "$path" | platformSed -e "s/\([^:]*:[^:]*:\).\{$max_length\}.*/\\1 <<<Too Long line replaced > $max_length >>>/g"

   if [[ ! $LRS_QUIET == "true" ]]; then
       echo ""
       echo "// lrs notes "
       echo "// use LRS_QUIET="true" to hide this section"
       echo "// use LRS_MAX_LENGHT to change the max line length allowed (current $max_length)"
   fi
}

# vim:ft=bash:
