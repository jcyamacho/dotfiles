# jq (command-line JSON processor): https://jqlang.org/
if ! exists brew; then
  return
fi

install-jq() {
  info "Installing jq..."
  brew install jq
  reload
}

if exists jq; then
  uninstall-jq() {
    info "Uninstalling jq..."
    brew uninstall jq
    reload
  }
fi
