#!/bin/sh -x

for dotfile in .ackrc .gemrc .gdbinit .gitignore .dh-make-perl .module-setup .zshrc .zprofile .screenrc .vimrc .vim .toprc .inputrc
do
  rm -fr ~/$dotfile
  ln -s $PWD/$dotfile ~/$dotfile
done

mkdir -p ~/bin
cp -a $PWD/bin/* ~/bin
