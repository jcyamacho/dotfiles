# rbenv (Ruby version manager): https://github.com/rbenv/rbenv
install-rbenv() {
  info "Installing rbenv..."
  brew install rbenv
}

if exists rbenv; then
  eval "$(rbenv init - --no-rehash zsh)"

  uninstall-rbenv() {
    info "Uninstalling rbenv..."
    brew uninstall rbenv
    rm -rf $HOME/.rbenv
  }
fi
