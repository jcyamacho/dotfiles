# BUN (javascript runtime): https://bun.sh/
export BUN_INSTALL="$HOME/.bun"

if [ -s "$BUN_INSTALL/_bun" ]; then
  # managed by plugin
  # source "$BUN_INSTALL/_bun"
  export PATH="$BUN_INSTALL/bin:$PATH"

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
else
  install-bun() {
    info "Installing bun..."
    chmod -w ~/.zshrc
    curl -fsSL https://bun.sh/install | sh
    chmod +w ~/.zshrc
    reload
  }
fi
