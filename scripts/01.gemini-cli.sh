# Gemini CLI: https://github.com/google/gemini-cli
_install_gemini() {
  if ! exists npm; then
    warning "npm is not installed"
    return 1
  fi

  npm install -g @google/gemini-cli@latest  > /dev/null
}


if exists gemini; then
  update-gemini() {
    info "Updating gemini..."
    _install_gemini
  }

  uninstall-gemini() {
    info "Uninstalling gemini..."
    npm uninstall -g @google/gemini-cli  > /dev/null
    reload
  }

  updates+=(update-gemini)
else
  install-gemini() {
    info "Installing gemini..."
    _install_gemini
    reload
  }
fi
