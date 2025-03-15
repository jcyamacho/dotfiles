# RUST (programming language): https://www.rust-lang.org/
export CARGO_DIR="$HOME/.cargo"

if [ ! -d $CARGO_DIR ]; then
    info "Installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

[ -s "$CARGO_DIR/env" ] && \. "$CARGO_DIR/env"
