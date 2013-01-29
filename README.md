# dotfiles

## Install

### Homebrew

Install Xcode 4.x and [GCC](https://github.com/kennethreitz/osx-gcc-installer)

```
sudo chown -R `whoami` /usr/local
ruby -e "$(curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"

brew doctor
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
xcode-select -print-path

brew install \
 ack \
 aspell \
 cmake \
 coreutils \
 git \
 hub \
 tig \
 libxml2 \
 libxslt \
 proctools \
 readline \
 sqlite \
 watch \
 wget \
 zsh
```

### rbenv/ruby-build
```
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# ruby required libssl-dev libreadline6-dev libncurses5-dev libsqlite3-dev
# nokogiri required libxml2-dev libxslt1-dev
rbenv install 2.0.0-dev
rbenv global  2.0.0-dev
gem install bundler --pre
rbenv rehash
```

### plenv
```
git clone git://github.com/tokuhirom/plenv.git ~/.plenv

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

plenv install 5.16.2 -DDEBUGGING=-g --build-dir=~/.plenv/build
plenv global  5.16.2
plenv install-cpanm
plenv rehash
```
