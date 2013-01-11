export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

autoload -Uz add-zsh-hook
autoload -Uz is-at-least

## must be loaded before zaw-cdr
if is-at-least 4.3.11; then
  autoload -U chpwd_recent_dirs cdr
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ":chpwd:*" recent-dirs-max 5000
  zstyle ":chpwd:*" recent-dirs-default true
  zstyle ":completion:*" recent-dirs-insert always
fi

function source_if_exists() { [[ -f $1 ]] && source $1 }

source_if_exists ~/dotfiles/zsh/antigenrc
source_if_exists ~/perl5/perlbrew/etc/bashrc
source_if_exists /usr/local/etc/profile.d/z.sh

if [ -d /usr/local/share/npm/bin ]; then
  export PATH="/usr/local/share/npm/bin:$PATH"
  export NODE_PATH="/usr/local/share/npm/lib/node_modules"
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

if which hub >/dev/null 2>&1; then
  eval "$(hub alias -s zsh)"
fi

if [ xDarwin = x`uname` ]; then
  export CONFIGURE_OPTS="--with-opt-dir=/usr/local"
fi

disable r

export EDITOR='vim'
export PAGER='less -R'

export PERL_CPANM_OPT='-nq'
export GISTY_DIR="$HOME/gists"
export RBXOPT=-X19
