#!/bin/bash

set -eux

git submodule init
git submodule update

for dotfile in .gemrc .gitconfig .gitignore .screenrc .tigrc .vim .vimrc .zshenv .zprofile .zshrc
do
  if [ -e ~/$dotfile ]; then
    rm -fr ~/$dotfile
  fi
  ln -nfs $PWD/$dotfile ~/$dotfile
done

mkdir -p ~/.config/mise
ln -nfs $PWD/config/mise/config.toml ~/.config/mise/config.toml
