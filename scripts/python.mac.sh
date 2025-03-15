# pyenv (Python version manager): https://github.com/pyenv/pyenv
if ! exists pyenv; then
    info "Installing pyenv..."
    brew install pyenv
fi

eval "$(pyenv init -)"
