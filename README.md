# dotfiles

## Install

### Homebrew

```
xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew doctor

git clone git@github.com:kamipo/dotfiles.git
cd dotfiles

brew bundle
./dotsetup.sh

sudo vi /etc/shells
chpass -s /opt/homebrew/bin/zsh
```

### rbenv

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

export OPENSSL_ROOT=$(brew --prefix openssl)
export PATH="$OPENSSL_ROOT/bin:$PATH"
export LDFLAGS="-L$OPENSSL_ROOT/lib"
export CPPFLAGS="-I$OPENSSL_ROOT/include"
export PKG_CONFIG_PATH="$OPENSSL_ROOT/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_ROOT"

# ruby required openssl libyaml, and rust for YJIT
rbenv install 3.2.3 --keep
rbenv global  3.2.3
rbenv rehash
```

### plenv

```
git clone https://github.com/tokuhirom/plenv.git ~/.plenv
git clone https://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init - zsh)"

plenv install 5.38.2 -DDEBUGGING=-g --build-dir=~/.plenv/build
plenv global  5.38.2
plenv install-cpanm
plenv rehash
```
