#!/bin/bash

git submodule init
git submodule update

cd .vim/autoload
ln -vnfs ../bundle/vim-pathogen/autoload/pathogen.vim .
cd -

for dotfile in .ackrc .caprc .gdbinit .gemrc .inputrc .pryrc .railsrc .screenrc .toprc .vim .vimrc .zshrc .zprofile
do
  rm -fr ~/$dotfile
  ln -vnfs $PWD/$dotfile ~/$dotfile
done
