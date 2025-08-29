# MISE (dev tools, env vars, task runner): https://mise.jdx.dev/

install-mise() {
  info "Installing mise..."
  curl https://mise.run | MISE_INSTALL_PATH="$CUSTOM_TOOLS_DIR/mise" sh > /dev/null
  reload
}

if exists mise; then
  eval "$(mise activate zsh)"

  uninstall-mise() {
    info "Uninstalling mise..."
    mise implode --yes
    reload
  }

  update-mise() {
    info "Updating mise..."
    mise self-update --yes
  }

  updates+=(update-mise)
fi
