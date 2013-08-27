if type keychain > /dev/null; then
  keychain ~/.ssh/github_key
  source ~/.keychain/$HOST-sh
fi

if [ -d ~/.autossh ]; then
  for script (~/.autossh/*) source "$script"
fi
