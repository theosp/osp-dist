#!/bin/bash

# Recursive search string in path's files
# rs(needle, path=".")
rs ()
{
   local needle="$1"
   local path="${2:-.}"

   find "$path" -type f -exec grep -Hn "$1" {} \;
}

# vim:ft=bash:
