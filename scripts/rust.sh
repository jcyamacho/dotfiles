# RUST (programming language): https://www.rust-lang.org/
install-rust() {
  info "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

export CARGO_DIR="$HOME/.cargo"

uninstall-rust() {
  info "Uninstalling rust..."
  rustup self uninstall
  rm -rf $CARGO_DIR
}

if [ -s "$CARGO_DIR/env" ]; then
  source "$CARGO_DIR/env"
fi
