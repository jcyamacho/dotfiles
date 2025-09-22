# ZIG (programming language): https://ziglang.org/
if ! exists brew; then
  return
fi

install-zig() {
  info "Installing zig..."
  brew install zig
  reload
}

if exists zig; then
  uninstall-zig() {
    info "Uninstalling zig..."
    brew uninstall zig
    reload
  }
fi
