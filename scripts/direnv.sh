# DIRENV (per directory env vars via .envrc): https://direnv.net/
install-direnv() {
  info "Installing direnv..."
  _install_direnv
}

_install_direnv() {
  export bin_path=$CUSTOM_TOOLS_DIR
  curl -sfL https://direnv.net/install.sh | bash
  unset bin_path
}

if exists direnv; then
  eval "$(direnv hook zsh)"

  uninstall-direnv() {
    info "Uninstalling direnv..."
    local bin_file="$CUSTOM_TOOLS_DIR/direnv"
    rm $bin_file
  }

  update-direnv() {
    info "Updating direnv..."
    _install_direnv
  }

  updates+=(update-direnv)
fi
