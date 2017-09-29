#!/bin/bash

set -eux

# Make sure using latest Homebrew
brew update

# Update already-installed formula (takes too much time, I will do it manually later)
brew upgrade

# Add Repository
brew tap homebrew/versions
brew tap homebrew/binary
brew tap homebrew/dupes
brew tap phinze/homebrew-cask
brew tap marcqualie/nginx

# Packages
brew install brew-cask

brew install git
brew install hub
brew install tig
brew install vim
brew install zsh
brew install screen

brew install ag
brew install aspell
brew install autoconf
brew install automake
brew install autossh
brew install awscli
brew install cmake
brew install coreutils
brew install elixir
brew install ffmpeg
brew install findutils
brew install geoipupdate
brew install gnu-sed
brew install gnu-tar
brew install go
brew install gpg
brew install heroku-toolbelt
brew install htop-osx
brew install jq
brew install keychain
brew install libffi
brew install mupdf-tools
brew install openssl
brew install parallel
brew install percona-toolkit
brew install pkg-config
brew install proctools
brew install pssh
brew install pstree
brew install qt@5.5
brew install readline
brew install socat
brew install sqlite
brew install ssh-copy-id
brew install tmux
brew install tree
brew install watch
brew install wget

brew install mysql
brew install postgresql
brew install redis

brew install ngrep
brew install tcpflow
brew install wireshark

# .dmg
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install java
brew cask install vagrant
brew cask install virtualbox

# Required java
brew install ec2-api-tools

# Remove outdated versions
brew cleanup
