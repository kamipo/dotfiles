if type keychain > /dev/null; then
  keychain ~/.ssh/github_key
  source ~/.keychain/$HOST-sh
fi

if [ -d ~/.local ]; then
  for script (~/.local/*) source "$script"
fi
