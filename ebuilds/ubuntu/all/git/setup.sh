#!/bin/bash

sudo aptitude install expat curl libcurl4-gnutls-dev libcurl4-openssl-dev

tar -xvjf git-1.7.2.3.tar.bz2
cd git-1.7.2.3
./configure --prefix=/
make all
sudo make install
