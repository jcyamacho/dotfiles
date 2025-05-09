# pyenv (Python version manager): https://github.com/pyenv/pyenv
install-pyenv() {
  brew install pyenv
}

if exists pyenv; then
  eval "$(pyenv init -)"
fi
