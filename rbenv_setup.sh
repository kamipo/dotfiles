#!/bin/bash

set -eux

if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  #ln -nfs $PWD/default-gems ~/.rbenv/default-gems
  mkdir -p ~/.rbenv/plugins
  cd ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git
  git clone https://github.com/rbenv/rbenv-default-gems.git
  git clone https://github.com/rkh/rbenv-update.git

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # ruby required libssl-dev libreadline6-dev libncurses5-dev libsqlite3-dev
  rbenv install 3.2.3 --keep
  rbenv global  3.2.3
  rbenv rehash
fi
