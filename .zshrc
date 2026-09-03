autoload -Uz compinit
compinit

autoload -Uz add-zsh-hook

bindkey -e

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search

## history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# share_history は inc_append_history / extended_history を含む
setopt share_history
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store

setopt correct
setopt auto_cd
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt complete_in_word
setopt complete_aliases
setopt no_flow_control
setopt no_clobber
setopt clobber_empty  # noclobber でも空ファイルだけは上書きを許す
setopt nonomatch

setopt no_prompt_cr
setopt transient_rprompt

alias ls='ls -A --color'
alias ll='ls -la'

function _ls_chpwd { ls -A --color }
add-zsh-hook chpwd _ls_chpwd

# menu は default タグで引かれるスタイルなので :completion:*:default に置く
zstyle ':completion:*:default' menu select
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'

# git 同梱の zsh 補完 (_git) は bash 補完スクリプトの場所を探すために
# 毎回 pkg-config を起動しており、初回の `git <TAB>` に 0.2〜0.3 秒かかる。
# 実際に使われるパスを直接指定して pkg-config の起動を省く。
for _f in ${HOMEBREW_ROOT:-/opt/homebrew}/share/zsh/site-functions/git-completion.bash \
          /usr/share/bash-completion/completions/git; do
  if [ -f $_f ]; then
    zstyle ':completion:*:*:git:*' script $_f
    break
  fi
done
unset _f

autoload -Uz vcs_info
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git

# git 用のフォーマット
# git のときはステージしているかどうかを表示
zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列

# rebase / merge 中の %m を短くする
# デフォルトは "%p (%n applied)" で、git だと %p が「完全SHA + subject」になって長い
zstyle ':vcs_info:git:*' patch-format '%n/%a'  # 適用済み/全体

# hooks 設定
# formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
# のメッセージを設定する直前のフック関数
# 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
# 各関数が最大3回呼び出される。
zstyle ':vcs_info:git+set-message:*' hooks \
                                        git-hook-begin \
                                        git-push-status \
                                        git-stash-count

# フックの最初の関数
# git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
# (.git ディレクトリ内にいるときは呼び出さない)
# .git ディレクトリ内では git status --porcelain などがエラーになるため
function +vi-git-hook-begin() {
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        # 0以外を返すとそれ以降のフック関数は呼び出されない
        return 1
    fi

    return 0
}

# push していないコミットの件数表示
#
# upstream に push していないコミットの件数を
# pN という形式で misc (%m) に表示する
function +vi-git-push-status() {
    # zstyle formats, actionformats の2番目のメッセージのみ対象にする
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    # @{upstream} を使うので main 以外のブランチでも動く
    local ahead
    ahead=$(command git rev-list --count '@{upstream}..HEAD' 2>/dev/null)

    if [[ "$ahead" -gt 0 ]]; then
        # misc (%m) に追加
        hook_com[misc]+="(p${ahead})"
    fi
}

# stash 件数表示
#
# stash している場合は :SN という形式で misc (%m) に表示
function +vi-git-stash-count() {
    # zstyle formats, actionformats の2番目のメッセージのみ対象にする
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    # --git-path は worktree や submodule でも正しいパスを返す
    local stash_log stash
    stash_log=$(command git rev-parse --git-path logs/refs/stash 2>/dev/null)
    [[ -f "$stash_log" ]] || return 0

    stash=${$(wc -l < "$stash_log")// /}
    if [[ "$stash" -gt 0 ]]; then
        # misc (%m) に追加
        hook_com[misc]+=":S${stash}"
    fi
}

# ブランチ名に % が含まれていてもプロンプトエスケープとして
# 再解釈されないよう、psvar 経由で渡す
function _update_vcs_info_msg() {
    psvar=()

    LANG=en_US.UTF-8 vcs_info

    # '%c%u %m' は中身が無いとスペースだけが残るので、
    # 空白で分割して詰め直すことで前後の余分なスペースを落とす
    local -a status_parts=( ${(s: :)vcs_info_msg_1_} )

    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    (( $#status_parts )) && psvar[2]="${(j: :)status_parts}"
    [[ -n "$vcs_info_msg_2_" ]] && psvar[3]="$vcs_info_msg_2_"
}

add-zsh-hook precmd _update_vcs_info_msg

# vcs_info の 1〜3 番目のメッセージをそれぞれ緑、黄色、赤で表示する
RPROMPT='%(1V.%F{green}%1v%f.)%(2V. %F{yellow}%2v%f.)%(3V. %F{red}%3v%f.)'

PROMPT='%F{yellow}[%~]'$'\n''%(?.%F{green}\(^o^%)/.%F{red}/(^o^%)\)[%n@%m]%#%f '

REPORTTIME=3

ulimit -c unlimited
ulimit -n 10240

# TERM ではなく $STY / $TMUX で判定する ($TERM は screenrc の term 設定に左右される)
# なお tmux 側で反映されるには `set -g allow-rename on` が必要
if [[ -n "$STY" || -n "$TMUX" ]]; then
  preexec () {
    echo -ne "\ek${1%% *}\e\\"
  }
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kamipo/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
