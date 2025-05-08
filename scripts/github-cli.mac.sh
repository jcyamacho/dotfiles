# GITHUB_CLI (GitHub on the command line): https://github.com/cli/cli
if ! exists gh; then
  info "Installing gh-cli..."
  brew install gh
fi
