#!/bin/bash

git submodule init
git submodule update

for dotfile in .ackrc .caprc .gdbinit .gemrc .inputrc .pryrc .railsrc .screenrc .toprc .vim .vimrc .zshrc .zprofile
do
  rm -fr ~/$dotfile
  ln -vnfs $PWD/$dotfile ~/$dotfile
done
