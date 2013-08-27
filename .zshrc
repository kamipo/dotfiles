autoload -U compinit
compinit -u

autoload -U colors
colors

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

antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zaw

bindkey -e

## zaw
bindkey -M filterselect '^m' accept-search
bindkey '^o' zaw-history
bindkey '^x^o' zaw-cdr

autoload -U history-search-end
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

setopt correct
setopt auto_cd
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt complete_in_word
setopt complete_aliases
setopt no_flow_control
setopt no_clobber
setopt nonomatch

setopt prompt_subst
setopt no_prompt_cr
setopt transient_rprompt

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
alias -g J='| jq'

if type dstat > /dev/null; then
  alias dstat-full='dstat -Tclmdrn'
  alias dstat-mem='dstat -Tclm'
  alias dstat-cpu='dstat -Tclr'
  alias dstat-net='dstat -Tclnd'
  alias dstat-disk='dstat -Tcldr'
fi

alias mysqld-verbose-help='mysqld --verbose --help'
alias spell='aspell list -l en'
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"
alias nlconv='perl -i -pe '"'"'s/\x0D\x0A|\x0D|\x0A/\n/g'"'"

if [ xLinux = x`uname` ]; then
  alias crontab='crontab -i'
  alias hwaddr='ip link show | grep -m1 ether | awk '"'"'{print $2}'"'"
fi

function static_httpd {
  if type plackup > /dev/null; then
    plackup -MPlack::App::Directory -e 'Plack::App::Directory->new(root => ".")->to_app'
  elif type ruby > /dev/null; then
    if ruby -v | grep -qm1 'ruby 2\.'; then
      ruby -run -e httpd -- --port=5000 .
    else
      ruby -rwebrick -e 'WEBrick::HTTPServer.new(:Port => 5000, :DocumentRoot => ".").start'
    fi
  elif type python > /dev/null; then
    if python -V 2>&1 | grep -qm1 'Python 3\.'; then
      python -m http.server 5000
    else
      python -m SimpleHTTPServer 5000
    fi
  elif type node > /dev/null; then
    node -e "var c=require('connect'), d=process.env.PWD; c().use(c.logger()).use(c.static(d)).use(c.directory(d)).listen(5000);"
  elif type php > /dev/null && php -v | grep -qm1 'PHP 5\.[45]\.'; then
    php -S 0.0.0.0:5000
  elif type erl > /dev/null; then
    erl -eval 'inets:start(), inets:start(httpd, [{server_name, "httpd"}, {server_root, "."}, {document_root, "."}, {port, 5000}])'
  fi
}

function _ls_chpwd { ls -A --color }
add-zsh-hook chpwd _ls_chpwd

zstyle ':completion:*' menu select
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'

autoload -Uz vcs_info
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

if is-at-least 4.3.10; then
    # git 用のフォーマット
    # git のときはステージしているかどうかを表示
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
    zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列
fi

# hooks 設定
if is-at-least 4.3.11; then
    # git のときはフック関数を設定する

    # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    # のメッセージを設定する直前のフック関数
    # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
    # 各関数が最大3回呼び出される。
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-push-status \
                                            git-nomerge-branch \
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

    # untracked フィアル表示
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # unstaged (%u) に ? を表示
    function +vi-git-untracked() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # unstaged (%u) に追加
            hook_com[unstaged]+='?'
        fi
    }

    # push していないコミットの件数表示
    #
    # リモートリポジトリに push していないコミットの件数を
    # pN という形式で misc (%m) に表示する
    function +vi-git-push-status() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" != "master" ]]; then
            # master ブランチでない場合は何もしない
            return 0
        fi

        # push していないコミット数を取得する
        local ahead
        ahead=$(command git rev-list origin/master..master 2>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ "$ahead" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # マージしていない件数表示
    #
    # master 以外のブランチにいる場合に、
    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
    # (mN) という形式で misc (%m) に表示
    function +vi-git-nomerge-branch() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # master ブランチの場合は何もしない
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "$nomerged" -gt 0 ]] ; then
            # misc (%m) に追加
            hook_com[misc]+="(m${nomerged})"
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

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+=":S${stash}"
        fi
    }

fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=""
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    RPROMPT="$prompt"
}

add-zsh-hook precmd _update_vcs_info_msg

PROMPT='%{$fg[yellow]%}[%~]'$'\n''%(?.%{$fg[green]%}\(^o^%)/.%{$fg[red]%}/(^o^%)\)[%n@%m]%#%{$reset_color%} '

REPORTTIME=3

ulimit -c unlimited
ulimit -n 10240

if [ $TERM = "screen" ]; then
  preexec () {
    echo -ne "\ek${1%% *}\e\\"
  }
fi
