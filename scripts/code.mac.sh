# Cursor (IDE): https://www.cursor.com/
install-code() {
  info "Installing cursor..."
  brew install --cask visual-studio-code
}

uninstall-code() {
  info "Uninstalling code..."
  brew uninstall visual-studio-code
}

if exists code; then
  c() {
    local dir=${1:-$(pwd)}
    code $dir
  }
fi
