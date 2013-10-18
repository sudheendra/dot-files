#!/bin/bash

# Use as you wish.

ln -sf $PWD/.alias ~/.alias
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.vim ~/.vim
ln -sf $PWD/.hgrc ~/.hgrc
ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.toprc ~/.toprc
ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.screenrc ~/.screenrc
ln -sf $PWD/.tmux.conf ~/.tmux.conf
ln -sf $PWD/.valgrindrc ~/.valgrindrc
echo "Created links. Now you can change the configuration files as required or use the defaults."
echo "Notable files to be changed: .gitconfig .hgrc .vimrc .alias .bashrc"
echo -n "Modify the configuration files? (y/n)"
read -n1 ans
if [ "$ans" = "y" -o "$ans" = "Y" ]; then
    vim .hgrc
    vim .gitconfig
    vim .vimrc
    vim .alias
    vim .bashrc
else
    echo
fi
