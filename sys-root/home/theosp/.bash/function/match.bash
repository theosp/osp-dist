#!/bin/bash

# match(regexp, replace_function)
# example:
# echo "daniel" | match '/danie(l)/' 'function (a, m1, m2, ...) {console.log(m1)}'
match ()
{
    local regexp="$1" replace="$2"

    local matching_script="$(cat <<EOF
        var stdin = require("fs").readFileSync("/dev/stdin").toString();

        stdin.replace(${regexp}, ${replace});
    
EOF
)"

    exec node -e "$matching_script"
}

# vim:ft=bash:
