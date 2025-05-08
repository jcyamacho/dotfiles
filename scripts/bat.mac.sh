# BAT (A cat(1) clone with wings): https://github.com/sharkdp/bat
if ! exists bat; then
  info "Installing bat..."
  brew install bat
fi
