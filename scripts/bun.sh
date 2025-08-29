# BUN (javascript runtime): https://bun.sh/
export BUN_INSTALL="$HOME/.bun"

install-bun() {
  info "Installing bun..."
  chmod -w ~/.zshrc
  curl -fsSL https://bun.sh/install | sh
  chmod +w ~/.zshrc
  _activate_bun
}

_activate_bun() {
  source "$BUN_INSTALL/_bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
}

if [ -s "$BUN_INSTALL/_bun" ]; then
  _activate_bun

  uninstall-bun() {
    info "Uninstalling bun..."
    rm -rf $BUN_INSTALL
    reload
  }

  update-bun() {
    info "Updating bun..."
    bun upgrade
  }

  updates+=(update-bun)
fi
