# Gemini CLI: https://github.com/google/gemini-cli
install-gemini() {
  if ! exists npm; then
    warning "npm is not installed"
    return 1
  fi

  info "Installing gemini..."

  npm install -g @google/gemini-cli@latest

  reload
}

if exists gemini; then
  update-gemini() {
    info "Updating gemini..."
    npm install -g @google/gemini-cli@latest
  }

  uninstall-gemini() {
    info "Uninstalling gemini..."
    npm uninstall -g @google/gemini-cli
    reload
  }

  updates+=(update-gemini)
fi
