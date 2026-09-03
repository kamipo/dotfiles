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

### mise

`brew bundle` で mise が入り、`./dotsetup.sh` で `~/.config/mise/config.toml`
(`config/mise/config.toml` へのシンボリックリンク) が配置される。
あとはそこに書かれているバージョンをインストールするだけ。

```
export OPENSSL_ROOT=$(brew --prefix openssl)
export PATH="$OPENSSL_ROOT/bin:$PATH"
export LDFLAGS="-L$OPENSSL_ROOT/lib"
export CPPFLAGS="-I$OPENSSL_ROOT/include"
export PKG_CONFIG_PATH="$OPENSSL_ROOT/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_ROOT"

# ruby required openssl libyaml, and rust for YJIT
mise install
```

バージョンを上げるときは `config/mise/config.toml` を書き換えて `mise install`。

```
mise use -g ruby@4.0.6  # config.toml を書き換えつつインストールする場合
```
