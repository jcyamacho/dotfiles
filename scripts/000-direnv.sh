# DIRENV (per directory env vars via .envrc): https://direnv.net/
update-direnv() {
  export bin_path=$CUSTOM_TOOLS_DIR
  info "Installing direnv..."
  curl -sfL https://direnv.net/install.sh | bash
  unset bin_path
}

if ! exists direnv; then
  update-direnv
fi

eval "$(direnv hook zsh)"
