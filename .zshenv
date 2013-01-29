export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

function source_if_exists() { [[ -f $1 ]] && source $1 }

source_if_exists ~/dotfiles/zsh/antigen/antigen.zsh

antigen-bundle rbenv
antigen-bundle bundler

if [ -d /usr/local/share/npm/bin ]; then
  export PATH="/usr/local/share/npm/bin:$PATH"
  export NODE_PATH="/usr/local/share/npm/lib/node_modules"
fi

if [ -d "$HOME/.plenv/bin" ]; then
  export PATH="$HOME/.plenv/bin:$PATH"
  eval "$(plenv init -)"
fi

if [ -d "$HOME/mysql-build/bin" ]; then
  export PATH="$HOME/mysql-build/bin:$PATH"
fi

if [ -d "$(brew --prefix coreutils)/libexec/gnubin" ]; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

if [ -d /usr/local/lib/pkgconfig ]; then
  export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
fi

if which hub > /dev/null; then
  eval "$(hub alias -s zsh)"
fi

if [ xDarwin = x`uname` ]; then
  export CONFIGURE_OPTS="--with-opt-dir=/usr/local"
fi

export EDITOR='vim'
export PAGER='less -R'

export PERL_CPANM_OPT='-nq'
export RBXOPT=-X19

disable r
