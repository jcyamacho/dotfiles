# Cursor (IDE): https://www.cursor.com/
if ! exists cursor; then
  info "Installing cursor..."
  brew install --cask cursor
fi

c() {
  local dir=${1:-$(pwd)}
  cursor $dir
}
