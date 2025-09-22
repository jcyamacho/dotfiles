# BAT (A cat(1) clone with wings): https://github.com/sharkdp/bat
if ! exists brew; then
  return
fi

install-bat() {
  info "Installing bat..."
  brew install bat
}

uninstall-bat() {
  info "Uninstalling bat..."
  brew uninstall bat
}
