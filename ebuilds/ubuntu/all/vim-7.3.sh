#!/bin/bash

# setup vim-7.3 from source

sudo apt-get install build-essential libncurses5-dev

wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2

tar -xvjf vim-7.3.tar.bz2

cd vim73

./configure --with-x --bindir /usr/bin --with-features=big
make
sudo make install

#sudo mv /usr/bin/vi /usr/bin/vi~
#sudo ln -s /usr/bin/vim /usr/bin/vi

cd ..

#rm vim-7.3.tar.bz2
