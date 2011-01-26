#!/bin/sh -x

git submodule init
git submodule update

cd .vim/autoload
ln -sf ../bundle/vim-pathogen/autoload/pathogen.vim .
cd -

for dotfile in .ackrc .gemrc .gdbinit .gitignore .dh-make-perl .module-setup .zshrc .zprofile .screenrc .vimrc .vim .toprc .inputrc bin
do
  rm -fr ~/$dotfile
  ln -s $PWD/$dotfile ~/$dotfile
done
