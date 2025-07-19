# uv (An extremely fast Python package and project manager, written in Rust): https://docs.astral.sh/uv/

_init_uv() {
  eval "$(uv generate-shell-completion zsh)"
  if ! exists python; then
    info "Installing python..."
    uv python install --default --preview
    uv python upgrade --preview
  fi
  if ! exists ruff; then
    info "Installing ruff..."
    uv tool install ruff@latest
  fi
  if ! exists pyright; then
    info "Installing pyright..."
    uv tool install pyright@latest
  fi
}

alias install-python="install-uv"
install-uv() {
  info "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  _init_uv
}

alias update-python="update-uv"
update-uv() {
  uv self update
  uv python upgrade
  uv tool update ruff
  uv tool update pyright
}

alias uninstall-python="uninstall-uv"
uninstall-uv() {
  uv cache clean
  rm -r "$(uv python dir)"
  rm -r "$(uv tool dir)"
  rm $HOME/.local/bin/uv $HOME/.local/bin/uvx
}

if exists uv; then
  _init_uv
fi
