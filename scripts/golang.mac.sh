# go (Go programming language): https://golang.org/
if ! exists go; then
  info "Installing go..."
  brew install go
fi

alias gmt="go mod tidy"

gmi() {
  local namespace=$(pwd | grep -o 'github.com.*')
  if [[ -z $namespace ]]; then
      namespace=$(basename "$(pwd)")
  fi

  go mod init $namespace

  if [ ! -f main.go ]; then
      cat > main.go <<EOF
package main

import (
    "log/slog"
)

func main() {
    slog.Info("Hello, World!")
}

EOF
  fi
}
