#!/bin/bash

# setup vim-7.3 from source

wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2

tar -xvjf vim-7.3.tar.bz2

cd vim73

./configure --with-x --bindir /usr/bin
make
sudo make install

#sudo mv /usr/bin/vi /usr/bin/vi~
#sudo ln -s /usr/bin/vim /usr/bin/vi

cd ..

#rm vim-7.3.tar.bz2
