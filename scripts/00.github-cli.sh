# GITHUB_CLI (GitHub on the command line): https://github.com/cli/cli
if (( ! $+commands[brew] )); then
  return
fi

if (( $+commands[gh] )); then
  # managed by plugin
  # eval "$(gh completion -s zsh)"

  uninstall-gh() {
    info "Uninstalling gh-cli..."
    brew uninstall gh
    reload
  }
else
  install-gh() {
    info "Installing gh-cli..."
    brew install gh
    reload
  }
fi
