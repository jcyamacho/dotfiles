# DENO (javascript runtime): https://deno.land/
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

install-deno() {
  info "Installing deno..."
  curl -fsSL https://deno.land/install.sh | sh -s -- --no-modify-path -y
}

uninstall-deno() {
  info "Uninstalling deno..."
  rm -rf $DENO_INSTALL
}
