#!/bin/bash

sudo apt-get install ncurses-term

apt-get source rxvt-unicode
sudo apt-get build-dep rxvt-unicode
cd rxvt-unicode*
patch -p1 < doc/urxvt-8.2-256color.patch
sudo dpkg-buildpackage -us -uc
cd ..
sudo dpkg -i rxvt-unicode_*.deb

echo "rxvt-unicode hold" | sudo dpkg --set-selections
