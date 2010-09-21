#!/bin/bash

sudo aptitude install libxml2-dev libxslt1-dev

tar -xvzf lxml-2.2.7.tgz
cd lxml-2.2.7
make
sudo python setup.py install
