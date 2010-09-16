#!/bin/bash

# setup vim-7.3 from source

wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2

tar -xvjf vim-7.3.tar.bz2

cd vim73

./configure --with-x
make
make install

cd ..

#rm vim-7.3.tar.bz2
