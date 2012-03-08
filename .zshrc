autoload -U compinit
compinit -u

autoload -U colors
colors

bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

## history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt append_history
setopt share_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store

#setopt noclobber
setopt correct
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt no_flow_control
setopt magic_equal_subst
setopt complete_in_word
setopt complete_aliases

setopt nonomatch
setopt prompt_subst
unsetopt promptcr

alias provejs='prove --ext=.js --exec=node'
alias provephp='prove --ext=.php --exec=php'

alias static_httpd='plackup -MPlack::App::Directory -e '"'"'Plack::App::Directory->new({root=>"."})->to_app'"'"
alias spell='aspell list -l en'
alias perlman='PAGER='"'"'vi -c "setf man"'"'"' perldoc -otext'
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"
alias nlconv='perl -i -pe '"'"'s/\x0D\x0A|\x0D|\x0A/\n/g'"'"
alias hwaddr='ip link show|grep ether|head -1|awk '"'"'{print $2}'"'"

alias be='bundle exec'
alias ce='carton exec'

# see http://d.hatena.ne.jp/hirose31/20120229/1330501968
alias dstat-full='dstat -Tclmdrn'
alias dstat-mem='dstat -Tclm'
alias dstat-cpu='dstat -Tclr'
alias dstat-net='dstat -Tclnd'
alias dstat-disk='dstat -Tcldr'

alias ls='ls -A --color'
alias ll='ls -la'
alias lll='ll -t'

alias -g V='| vim -R -'
alias -g L='| less -R'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'
alias -g X='| xargs'

export EDITOR='vim'
export PAGER='less -R'
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/lib

export GISTY_DIR="$HOME/gists"

# for Rubinius
export RBXOPT=-X19

if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if [ -f "/usr/libexec/java_home" ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=$JAVA_HOME/bin:$PATH
fi

if [ -d "/usr/local/cassandra" ]; then
  export CASSANDRA_HOME=/usr/local/cassandra
fi

if [ -d "$HOME/pear/bin" ]; then
  export PATH=$HOME/pear/bin:$PATH
fi

if [ -s "$HOME/.nvm/nvm.sh" ]; then
  source $HOME/.nvm/nvm.sh
fi

if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  source $HOME/.rvm/scripts/rvm
fi

if [ -f "$HOME/perl5/perlbrew/etc/bashrc" ]; then
  source $HOME/perl5/perlbrew/etc/bashrc
fi

if [ -d "/usr/local/lib/pkgconfig" ]; then
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
fi

if [ -d "/usr/local/lib/python2.6/site-packages" ]; then
  export PYTHONPATH="/usr/local/lib/python2.6/site-packages/:$PYTHONPATH"
fi

if [ -f "/usr/local/etc/autojump" ]; then
  source /usr/local/etc/autojump
fi

if [ -d "$HOME/.autossh" ]; then
  source $HOME/.autossh/*
fi

if [ -f "/etc/debian_version" ]; then
  export DEBEMAIL="kamipo@gmail.com"
  export DEBFULLNAME="Ryuta Kamizono"
fi

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

precmd () {
    psvar=()
    LC_ALL=C LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

RPROMPT="%1(v|%F{green}%1v%f|)"
PROMPT='%{%(?.$fg[green].$fg[red])%}$(owata)[%n@%m]%~%#%{$reset_color%} '

ulimit -c unlimited
ulimit -n 10240

umask g+w

function history-all { history -E 1 }
function chpwd() { ls }
function owata {
  if [ $? -eq 0 ]; then
    echo "\\(^o^)/"
  else
    echo "/(^o^)\\"
  fi
}

if [ $TERM = "screen" ]; then
  preexec () {
    echo -ne "\ek${1%% *}\e\\"
  }
fi
