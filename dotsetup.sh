#!/bin/bash

set -eux

git submodule init
git submodule update

for dotfile in .gemrc .gitconfig .gitignore .screenrc .tigrc .vim .vimrc .zshenv .zshrc
do
  if [ -e ~/$dotfile ]; then
    rm -fr ~/$dotfile
  fi
  ln -nfs $PWD/$dotfile ~/$dotfile
done
