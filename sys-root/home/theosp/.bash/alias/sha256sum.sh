alias sha256sum="shasum -a 256"

hashes_file="hashes.txt"

sha256sum-rec () {
    find $1 -type f -exec sha256sum {} \;
}

sha256sum-produce-hashes-file () {
    # If an hashes file already exists, check with the user if they want to overwrite it
    if [ -f "$hashes_file" ]; then
        read -p "Hashes file already exists. Overwrite? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborting"
            return 1
        fi
    fi

    sha256sum-rec . > "$hashes_file"
}

sha256sum-verify-hashes-file () {
    sha256sum -c "$hashes_file"
}