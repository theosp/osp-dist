alias sha256sum="shasum -a 256"

hashes_file="sha256-hashes.txt"

sha256sum-rec () {
    local path="$1"
    shift
    local find_extra_args=( "$@" )

    # if not provided a path, use the current directory
    if [ -z "$path" ]; then
        path="."
    fi

    # If not a directory, print an error
    if [ ! -d "$path" ]; then
        echo "Error: $path is not a directory"
        return 1
    fi

    platformFind "$path" -type f "${find_extra_args[@]}" -exec sha256sum {} \;
}

sha256sum-produce-hashes-file () {
    # If an hashes file already exists, check with the user if they want to overwrite it
    if [ -f "$hashes_file" ]; then
        read -p "Hashes file \`$hashes_file\` already exists. Overwrite? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborting"
            return 1
        fi
    fi

    sha256sum-rec . -and ! -name "$hashes_file" | tee "$hashes_file"

    echo "Hashes file \`$hashes_file\` created"
}

sha256sum-verify-hashes-file () {
    sha256sum -c "$hashes_file"
}