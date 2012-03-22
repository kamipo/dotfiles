#!/bin/sh -x

git submodule init
git submodule update

cd .vim/autoload
ln -sf ../bundle/vim-pathogen/autoload/pathogen.vim .
cd -

for dotfile in .ackrc .caprc .gdbinit .gemrc .inputrc .pryrc .screenrc .toprc .vim .vimrc .zshrc .zprofile
do
  rm -fr ~/$dotfile
  ln -nfs $PWD/$dotfile ~/$dotfile
done
