# rbenv (Ruby version manager): https://github.com/rbenv/rbenv
install-rbenv() {
  info "Installing rbenv..."
  brew install rbenv
}

uninstall-rbenv() {
  info "Uninstalling rbenv..."
  brew uninstall rbenv
  rm -rf $HOME/.rbenv
}

if exists rbenv; then
  eval "$(rbenv init - --no-rehash zsh)"
fi
