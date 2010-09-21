#!/bin/bash

tar -xvjf git-1.7.2.3.tar.bz2
cd git-1.7.2.3
./configure --prefix=/
make
sudo make install
