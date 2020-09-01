#!/bin/bash

shopt -s nocasematch

sudo apt-get update

echo -n "Need SSH key (Y/n)? "
IFS= read -r gen_ssh
if [[ "$gen_ssh" =~ [y] ]]
then
    # Generate an SSH key
    echo -n "Enter your github user email: "
    IFS= read -r email
    ssh-keygen -t rsa -C "$email"
fi

echo -n "Install Git ([Y]es/[n]o)? "
IFS= read -r install_git
case "$install_git" in
    [^n])
        sudo apt-get install git-core
    ;;
esac

echo -n "Print public key ([x]clip/[c]at/[N]one)? "
IFS= read -r print_public_key
case "$print_public_key" in
    [x])
        sudo apt-get install xclip
        cat ~/.ssh/id_rsa.pub | xclip -sel clip
    ;;
    [c])
        cat ~/.ssh/id_rsa.pub
    ;;
esac

echo -n "Press enter when you are ready to clone..."
read
git clone https://github.com/theosp/osp-dist.git
cd osp-dist

echo -n "Installation type ([c]ore/[d]esktop/[N]one)?"
IFS= read -r installation_type
case "$installation_type" in
    [c])
        ./setup-core.sh
    ;;
    [d])
        ./setup-core.sh
        ./setup-desktop.sh
    ;;
esac
