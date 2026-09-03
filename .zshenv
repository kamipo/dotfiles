export HOMEBREW_ROOT="/opt/homebrew"

# 同じディレクトリが PATH に重複して積まれるのを防ぐ
typeset -U path fpath

# PATH が空/不完全でも壊れないように最低限のベースを末尾に足しておく
# (先頭に足すと mise/fnm や Homebrew より /usr/bin が優先されてしまう)
path=($path /usr/bin /bin /usr/sbin /sbin)

# 重複除去 (typeset -U) は配列 path への代入でのみ効くので、
# PATH="...:$PATH" ではなく path=(... $path) の形で足していく
path=($HOMEBREW_ROOT/bin $HOMEBREW_ROOT/sbin $path)
path=($HOMEBREW_ROOT/opt/postgresql@17/bin $path)
path=($HOME/bin $path)

eval "$(mise activate zsh)"

if type fnm > /dev/null; then
  eval "$(fnm env --use-on-cd --resolve-engines)"
fi

function prepend_path_if_exists { [[ -d "$1" ]] && path=("$1" $path) }

export GOPATH=$HOME
prepend_path_if_exists "$GOPATH/bin"
prepend_path_if_exists "$HOME/mysql-build/bin"
prepend_path_if_exists $HOMEBREW_ROOT/share/git-core/contrib/workdir
prepend_path_if_exists $HOMEBREW_ROOT/share/git-core/contrib/diff-highlight
prepend_path_if_exists $HOMEBREW_ROOT/share/npm/bin && {
  export NODE_PATH="$HOMEBREW_ROOT/share/npm/lib/node_modules"
}

if [ -d $HOMEBREW_ROOT/lib/pkgconfig ]; then
  export PKG_CONFIG_PATH="$HOMEBREW_ROOT/lib/pkgconfig"
fi

if type bundle > /dev/null; then
  alias be='bundle exec'
  export BUNDLE_AUTO_INSTALL=true
fi

if [ "Darwin" = "$(uname)" ]; then
  if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
    prepend_path_if_exists "$JAVA_HOME/bin"
  fi

  prepend_path_if_exists "$HOMEBREW_ROOT/opt/coreutils/libexec/gnubin"

  export RUBY_CONFIGURE_OPTS="--with-readline-dir=$HOMEBREW_ROOT/opt/readline --with-openssl-dir=$HOMEBREW_ROOT/opt/openssl"
  export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix zstd)/lib/"
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

export LANG='ja_JP.UTF-8'
export EDITOR='vim'
export PAGER='less'
export LESS='-R -g -j10 --no-init --quit-if-one-screen'

export COMPOSE_PROFILES=middleware,test-middleware

disable r

# ログインシェルでは ~/.zshenv の後に /etc/zprofile が path_helper を実行し、
# /etc/paths* の内容が PATH の先頭に差し込まれてここまでの優先順位が壊れる。
# ~/.zprofile で並びを戻せるよう、この時点の PATH を控えておく。
typeset -ga _zshenv_path
_zshenv_path=($path)
