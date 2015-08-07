alias sd='sudo docker' # sudo docker

youtube () {
    url="$1"

    output_folder="$PWD"

    file_name=$(curl "$url" | sed -n 's/.*<title>\(.*\) - YouTube<\/title>.*/\1/Ip' | sed -n 's/[^a-zA-Z]\+/-/Ipg' | tr '[:upper:]' '[:lower:]')

    file_name="$file_name.mp4"

    echo $output_folder
    echo $file_name

    docker run -it --rm -v "$output_folder:/tmp" jbergknoff/youtube-dl -o "/tmp/$file_name" "$url"

    sudo chown "$USER:$USER" "$output_folder/$file_name"
}
