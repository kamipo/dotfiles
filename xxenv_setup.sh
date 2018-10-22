#!/bin/bash

set -eux

if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  ln -nfs $PWD/default-gems ~/.rbenv/default-gems
  mkdir -p ~/.rbenv/plugins
  cd ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git
  git clone https://github.com/rbenv/rbenv-default-gems.git
  git clone https://github.com/rkh/rbenv-update.git

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # ruby required libssl-dev libreadline6-dev libncurses5-dev libsqlite3-dev
  rbenv install 2.5.3 --keep
  rbenv global  2.5.3
  rbenv rehash
fi

if [ ! -d ~/.plenv ]; then
  git clone https://github.com/tokuhirom/plenv.git ~/.plenv
  mkdir -p ~/.plenv/plugins
  cd ~/.plenv/plugins
  git clone https://github.com/tokuhirom/Perl-Build.git perl-build

  export PATH="$HOME/.plenv/bin:$PATH"
  eval "$(plenv init -)"

  plenv install 5.26.1 -DDEBUGGING=-g --build-dir=~/.plenv/build
  plenv global  5.26.1
  plenv install-cpanm
  plenv rehash
fi
