# Claude Code CLI: https://www.anthropic.com/claude-code
install-claude() {
  if ! exists npm; then
    warning "npm is not installed"
    return 1
  fi

  info "Installing claude..."
  npm install -g @anthropic-ai/claude-code
}

alias update-claude="claude update"

uninstall-claude() {
  info "Uninstalling claude..."
  npm uninstall -g @anthropic-ai/claude-code
}
