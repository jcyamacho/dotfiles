# DENO (javascript runtime): https://deno.land/
export DENO_INSTALL="$HOME/.deno"

if [ -s "$DENO_INSTALL/bin/deno" ]; then
  export PATH="$DENO_INSTALL/bin:$PATH"

  # managed by plugin
  # eval "$(deno completions zsh)"

  uninstall-deno() {
    info "Uninstalling deno..."
    rm -rf $DENO_INSTALL
    reload
  }

  update-deno() {
    info "Updating deno..."
    deno upgrade
  }

  updates+=(update-deno)
else
  install-deno() {
    info "Installing deno..."
    curl -fsSL https://deno.land/install.sh | sh -s -- --no-modify-path -y
    reload
  }
fi
