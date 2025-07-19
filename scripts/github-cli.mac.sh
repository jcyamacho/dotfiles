# GITHUB_CLI (GitHub on the command line): https://github.com/cli/cli
install-gh() {
  info "Installing gh-cli..."
  brew install gh
}

uninstall-gh() {
  info "Uninstalling gh-cli..."
  brew uninstall gh
}

if exists gh; then
  eval "$(gh completion -s zsh)"
fi
