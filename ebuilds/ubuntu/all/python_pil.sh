#!/bin/bash

sudo aptitude install python-dev libjpeg62-dev

wget http://effbot.org/downloads/Imaging-1.1.7.tar.gz

tar -xvzf Imaging-1.1.7.tar.gz

cd Imaging-1.1.7

sudo python setup.py install
