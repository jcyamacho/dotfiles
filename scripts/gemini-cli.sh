# Gemini CLI: https://github.com/google/gemini-cli
install-gemini() {
  if ! exists npm; then
    warning "npm is not installed"
    return 1
  fi
  info "Installing gemini..."
  npm install -g @google/gemini-cli@latest
}

update-gemini() {
  info "Updating gemini..."
  npm update -g @google/gemini-cli
}

uninstall-gemini() {
  info "Uninstalling gemini..."
  npm uninstall -g @google/gemini-cli
}
