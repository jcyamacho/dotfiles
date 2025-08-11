# RUST (programming language): https://www.rust-lang.org/

export CARGO_DIR="$HOME/.cargo"

install-rust() {
  info "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  _init_rust
}

_init_rust() {
  source "$CARGO_DIR/env"
}

if [ -s "$CARGO_DIR/env" ]; then
  _init_rust

  uninstall-rust() {
    info "Uninstalling rust..."
    rustup self uninstall
    rm -rf $CARGO_DIR
  }

  update-rust() {
    info "Updating rust..."
    rustup update
  }

  updates+=(update-rust)
fi
