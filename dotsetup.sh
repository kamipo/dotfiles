#!/bin/bash

set -eux

git submodule init
git submodule update

for dotfile in .ackrc .editrc .gdbinit .gemrc .gitconfig .gitignore .inputrc .railsrc .screenrc .tigrc .toprc .vim .vimrc .zprofile .zshenv .zshrc
do
  if [ -e ~/$dotfile ]; then
    rm -fr ~/$dotfile
  fi
  ln -nfs $PWD/$dotfile ~/$dotfile
done
