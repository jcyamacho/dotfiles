# RUST (programming language): https://www.rust-lang.org/

export CARGO_DIR="$HOME/.cargo"

_init_rust() {
  source "$CARGO_DIR/env"
}

install-rust() {
  info "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  _init_rust
}

uninstall-rust() {
  info "Uninstalling rust..."
  rustup self uninstall
  rm -rf $CARGO_DIR
}

if [ -s "$CARGO_DIR/env" ]; then
    _init_rust
fi
