if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

export HOMEBREW_ROOT="/opt/homebrew"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOMEBREW_ROOT/bin:$HOMEBREW_ROOT/sbin:$PATH"
export PATH="$HOMEBREW_ROOT/opt/postgresql@17/bin:$PATH"
export PATH="$HOME/bin:$PATH"

if type fnm > /dev/null; then
  eval "$(fnm env --use-on-cd --resolve-engines)"
fi

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

if [ "Darwin" = "$(uname)" ]; then
  if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
    export_path_if_exists "$JAVA_HOME/bin"
  fi

  export_path_if_exists "$HOMEBREW_ROOT/opt/coreutils/libexec/gnubin"

  export RUBY_CONFIGURE_OPTS="--with-readline-dir=$HOMEBREW_ROOT/opt/readline --with-openssl-dir=$HOMEBREW_ROOT/opt/openssl"
  export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix zstd)/lib/"
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

export LANG='ja_JP.UTF-8'
export EDITOR='vim'
export PAGER='less'
export LESS='-R -g -j10 --no-init --quit-if-one-screen'

disable r
