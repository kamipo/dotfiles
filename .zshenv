export HOMEBREW_ROOT="/opt/homebrew"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOMEBREW_ROOT/bin:$HOMEBREW_ROOT/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

function export_path_if_exists { [[ -d "$1" ]] && export PATH="$1:$PATH" }

export GOPATH=$HOME
export_path_if_exists "$GOPATH/bin"
export_path_if_exists "$HOME/.rbenv/bin" && eval "$(rbenv init --no-rehash - zsh)"
export_path_if_exists "$HOME/.plenv/bin" && eval "$(plenv init - zsh)"
export_path_if_exists "$HOME/mysql-build/bin"
export_path_if_exists $HOMEBREW_ROOT/share/git-core/contrib/workdir
export_path_if_exists $HOMEBREW_ROOT/share/git-core/contrib/diff-highlight
export_path_if_exists $HOMEBREW_ROOT/share/npm/bin && {
  export NODE_PATH="$HOMEBREW_ROOT/share/npm/lib/node_modules"
}

if [ -d $HOMEBREW_ROOT/lib/pkgconfig ]; then
  export PKG_CONFIG_PATH="$HOMEBREW_ROOT/lib/pkgconfig"
fi

if type bundle > /dev/null; then
  alias be='bundle exec'
fi

if type hub > /dev/null; then
  alias git=hub
fi

if [ "Darwin" = "$(uname)" ]; then
  if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
    export_path_if_exists "$JAVA_HOME/bin"
  fi

  export_path_if_exists "$HOMEBREW_ROOT/opt/coreutils/libexec/gnubin"

  export RUBY_CONFIGURE_OPTS="--with-readline-dir=$HOMEBREW_ROOT/opt/readline --with-openssl-dir=$HOMEBREW_ROOT/opt/openssl"
fi

export LANG='ja_JP.UTF-8'
export EDITOR='vim'
export PAGER='less'
export LESS='-R -g -j10 --no-init --quit-if-one-screen'

disable r
