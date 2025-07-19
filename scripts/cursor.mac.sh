# Cursor (IDE): https://www.cursor.com/
install-cursor() {
  info "Installing cursor..."
  brew install --cask cursor
}

uninstall-cursor() {
  info "Uninstalling cursor..."
  brew uninstall cursor
}

if exists cursor; then
  cr() {
    local dir=${1:-$(pwd)}
    cursor $dir
  }
fi
