# ZED (A modern text editor): https://zed.dev/
install-zed() {
  info "Installing zed..."
  brew install --cask zed
}

if exists zed; then
  zd() {
    local dir=${1:-$(pwd)}
    zed $dir
  }

  uninstall-zed() {
    info "Uninstalling zed..."
    brew uninstall zed
  }
fi
