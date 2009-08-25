autoload -U compinit
compinit

autoload -U colors
colors

bindkey -e

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
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt no_flow_control
setopt magic_equal_subst
setopt complete_in_word
setopt complete_aliases

alias cpan-uninstall='perl -MConfig -MExtUtils::Install -e '"'"'($FULLEXT=shift)=~s{-}{/}g;uninstall "$Config{sitearchexp}/auto/$FULLEXT/.packlist",1'"'"
alias cpan-update-all='perl -MCPAN -e '"'"'CPAN::Shell->install(CPAN::Shell->r)'"'"
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"
alias nlconv='perl -i -pe '"'"'s/\x0D\x0A|\x0D|\x0A/\n/g'"'"

alias ls='ls -a --color=tty'
alias ll='ls -l --color=tty'

export EDITOR='vim'
export PAGER='less'
export MANPATH="/opt/local/share/man:$MANPATH"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"

if [ -d "$HOME/local" ]; then
  eval $(perl -I$HOME/local/lib/perl5 -Mlocal::lib=$HOME/local)
  export PATH="$HOME/local/bin:$PATH"
fi

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

PROMPT='[%n@%m]%~%# '
#PROMPT='[%D{%Y/%m/%d %H:%M}]%(!.#.$) '

umask g+w

function history-all { history -E 1 }
function chpwd() { ls }

if [ $TERM = "screen" ]; then
#  printf "\033P\033]0;$USER@$HOSTNAME\007\033\\"
#  preexec () {
#    echo -ne "\ek${1%% *}\e\\"
#  }
fi
