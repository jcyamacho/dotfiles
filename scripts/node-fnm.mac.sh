# fnm (Fast Node Manager): https://github.com/Schniz/fnm

_init_fnm() {
  eval "$(fnm completions --shell zsh)"
  eval "$(fnm env --use-on-cd --shell zsh)"

  if ! exists node; then
    update-node
  fi
}

alias install-node="install-fnm"
install-fnm() {
  info "Installing fnm..."
  brew install fnm
  _init_fnm
}

alias uninstall-node="uninstall-fnm"
uninstall-fnm() {
  brew uninstall fnm
  rm -rf $HOME/.local/state/fnm_multishells
}

update-node() {
  info "Activating latest LTS node..."
  fnm use --install-if-missing lts-latest

  local current_version=$(fnm current)
  fnm default "$current_version"
  info "Current Node.js version: $current_version"

  info "Updating npm..."
  npm install -g npm@latest

  info "Removing other Node.js versions..."

  info "Current version: $current_version"

  fnm list | grep -v "$current_version" | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+" | while read -r version; do
    info "Removing $version..."
    fnm uninstall "$version"
  done
}

if exists fnm; then
  _init_fnm
fi
