# ZED (A modern text editor): https://zed.dev/
if ! exists zed; then
    info "Installing zed..."
    brew install --cask zed
fi

zd() {
    local dir=${1:-$(pwd)}
    zed $dir
}