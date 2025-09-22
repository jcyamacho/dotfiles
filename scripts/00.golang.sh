# go (Go programming language): https://golang.org/
# golangci-lint (Go linter): https://golangci-lint.run/

if ! exists brew; then
  return
fi

# change the default GOPATH from $HOME/go to $HOME/.go
export GOPATH=$HOME/.go

install-go() {
  info "Installing go..."
  brew install go
  info "Installing golangci-lint..."
  brew install golangci-lint
  reload
}

if exists go; then
  go telemetry off

  uninstall-go() {
    info "Uninstalling golangci-lint..."
    brew uninstall golangci-lint
    info "Uninstalling go..."
    brew uninstall go
    info "Removing $GOPATH..."
    sudo rm -rf $GOPATH
    reload
  }

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
