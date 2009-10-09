#!/bin/sh

rm -v ~/.dh-make-perl ~/.module-setup ~/.zshrc ~/.zprofile ~/.screenrc ~/.vimrc ~/.vim ~/.toprc ~/.inputrc

ln -sv $PWD/.dh-make-perl ~/.dh-make-perl
ln -sv $PWD/.module-setup ~/.module-setup
ln -sv $PWD/.zshrc ~/.zshrc
ln -sv $PWD/.zprofile ~/.zprofile
ln -sv $PWD/.screenrc ~/.screenrc
ln -sv $PWD/.vimrc ~/.vimrc
ln -sv $PWD/.vim ~/.vim
ln -sv $PWD/.toprc ~/.toprc
ln -sv $PWD/.inputrc ~/.inputrc
