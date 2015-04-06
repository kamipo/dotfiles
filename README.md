# dotfiles

## Install

### Homebrew

Install Xcode 4.x and [GCC](https://github.com/kennethreitz/osx-gcc-installer)

```
sudo chown -R `whoami` /usr/local
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew doctor
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
xcode-select -print-path

./brewfile.sh
./dotsetup.sh

sudo vi /etc/shells
chpass -s /usr/local/bin/zsh
```

### rbenv

```
git clone git@github.com:sstephenson/rbenv.git ~/.rbenv
ln -nfs ~/dotfiles/default-gems ~/.rbenv/default-gems
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git@github.com:sstephenson/ruby-build.git
git clone git@github.com:sstephenson/rbenv-default-gems.git
git clone git@github.com:rkh/rbenv-update.git

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# ruby required libssl-dev libreadline6-dev libncurses5-dev libsqlite3-dev
# nokogiri required libxml2-dev libxslt1-dev
rbenv install 2.2.1
rbenv global  2.2.1
rbenv rehash
```

### plenv

```
git clone git@github.com:tokuhirom/plenv.git ~/.plenv
mkdir -p ~/.plenv/plugins
cd ~/.plenv/plugins
git clone git@github.com:tokuhirom/Perl-Build.git perl-build

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

plenv install 5.21.9 -DDEBUGGING=-g --build-dir=~/.plenv/build
plenv global  5.21.9
plenv install-cpanm
plenv rehash
```
