# ZIG (programming language): https://ziglang.org/
install-zig() {
  info "Installing zig..."
  brew install zig
}

if exists zig; then
  uninstall-zig() {
    info "Uninstalling zig..."
    brew uninstall zig
  }
fi
