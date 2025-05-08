# BUN (javascript runtime): https://bun.sh/
export BUN_DIR="$HOME/.bun"
if [ ! -d $BUN_DIR ]; then
  info "Installing bun..."
  curl -fsSL https://bun.sh/install | sh
fi

[ -s "$BUN_DIR/_bun" ] && source "$BUN_DIR/_bun"

export PATH="$BUN_DIR/bin:$PATH"
