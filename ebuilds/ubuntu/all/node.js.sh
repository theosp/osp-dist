#!/bin/bash

sudo aptitude install libssl-dev

git clone http://github.com/ry/node.git 

cd node

./configure
make 
make install
