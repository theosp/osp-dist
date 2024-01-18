alias sha256sum="shasum -a 256"

sha256sum-rec () {
    find $1 -type f -exec sha256sum {} \;
}
