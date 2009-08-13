#!/bin/sh
 
rm ~/.zshrc ~/.zprofile ~/.screenrc ~/.vimrc ~/.vim ~/.toprc
 
CWD=`pwd`
ln -s $CWD/.zshrc ~/.zshrc
ln -s $CWD/.zprofile ~/.zprofile
ln -s $CWD/.screenrc ~/.screenrc
ln -s $CWD/.vimrc ~/.vimrc
ln -s $CWD/.vim ~/.vim
ln -s $CWD/.toprc ~/.toprc
