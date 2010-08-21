if [ -x "/usr/local/bin/keychain" ]; then
  /usr/local/bin/keychain "$HOME/.ssh/github_key"
  source "$HOME/.keychain/$HOST-sh"
fi
