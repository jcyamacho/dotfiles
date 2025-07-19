# go (Go programming language): https://golang.org/
# golangci-lint (Go linter): https://golangci-lint.run/

# change the default GOPATH from $HOME/go to $HOME/.go
export GOPATH=$HOME/.go

install-go() {
  info "Installing go..."
  brew install go
  brew install golangci-lint
}

uninstall-go() {
  sudo rm -rf $(go env GOPATH)
  brew uninstall golangci-lint
  brew uninstall go
}

if exists go; then
  go telemetry off

  gmt() {
    go mod tidy
  }

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

fi
