if which keychain >/dev/null 2>&1; then
  keychain ~/.ssh/github_key
  source ~/.keychain/$HOST-sh
fi

if [ -d ~/.autossh ]; then
  for script (~/.autossh/*) source "$script"
fi
