if [ -d ~/.local ]; then
  for script (~/.local/*) source "$script"
fi
