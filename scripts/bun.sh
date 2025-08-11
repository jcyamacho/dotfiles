# BUN (javascript runtime): https://bun.sh/
export BUN_INSTALL="$HOME/.bun"

install-bun() {
  info "Installing bun..."
  chmod -w ~/.zshrc
  curl -fsSL https://bun.sh/install | sh
  chmod +w ~/.zshrc
}

if [ -s "$BUN_INSTALL/_bun" ]; then
  source "$BUN_INSTALL/_bun"
  export PATH="$BUN_INSTALL/bin:$PATH"

  uninstall-bun() {
    info "Uninstalling bun..."
    rm -rf $BUN_INSTALL
  }

  update-bun() {
    info "Updating bun..."
    bun upgrade
  }

  updates+=(update-bun)
fi
