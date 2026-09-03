# /etc/zprofile の path_helper は /etc/paths* の内容を PATH の先頭に差し込むため、
# ~/.zshenv で組み立てた優先順位 (mise/fnm や Homebrew が /usr/bin より前) が崩れる。
# ~/.zshenv 時点の並びを先頭に戻す。path_helper が足した分は後ろにそのまま残る。
# path は ~/.zshenv で typeset -U してあるので重複は自動的に取り除かれる。
if (( $#_zshenv_path )); then
  path=($_zshenv_path $path)
  unset _zshenv_path
fi
