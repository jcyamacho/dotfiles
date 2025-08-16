# uv (An extremely fast Python package and project manager, written in Rust): https://docs.astral.sh/uv/

alias install-python="install-uv"
install-uv() {
  info "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  _init_uv
}

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
  if ! exists basedpyright; then
    info "Installing basedpyright..."
    uv tool install basedpyright@latest
  fi
}

if exists uv; then
  _init_uv

  alias py="python"

  act() {
    activate=(
      "$(pwd)/.venv/bin/activate"
      "$(pwd)/venv/bin/activate"
    )
    for venv in "${activate[@]}"; do
      if [ -s "$venv" ]; then
        source "$venv"
        return
      fi
    done
  }

  alias update-python="update-uv"
  update-uv() {
    info "Updating uv..."
    uv self update
    info "Updating python..."
    uv python upgrade --preview
    info "Updating ruff..."
    uv tool update ruff
    info "Updating basedpyright..."
    uv tool update basedpyright
  }

  alias uninstall-python="uninstall-uv"
  uninstall-uv() {
    info "Uninstalling uv..."
    uv cache clean
    rm -rf "$(uv python dir)"
    rm -rf "$(uv tool dir)"
    rm $HOME/.local/bin/uv $HOME/.local/bin/uvx
  }

  updates+=(update-uv)
fi
