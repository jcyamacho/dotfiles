# Codex CLI: https://developers.openai.com/codex/cli
export CODEX_HOME="$HOME/.codex"
export CODEX_PROMPTS_DIR="$CODEX_HOME/prompts"

install-codex() {
  if ! exists npm; then
    warn "npm is not installed"
    return 1
  fi

  info "Installing codex..."
  npm install -g @openai/codex@latest > /dev/null
  mkdir -p "$CODEX_PROMPTS_DIR"
  reload
}

if exists codex; then
  cdx() {
    codex --search --sandbox workspace-write --ask-for-approval on-request "$@"
  }

  update-codex() {
    info "Updating codex..."
    npm install -g @openai/codex@latest > /dev/null
  }

  uninstall-codex() {
    info "Uninstalling codex..."
    npm uninstall -g @openai/codex > /dev/null
    rm -rf "$CODEX_HOME"
    reload
  }

  codex-config() {
    $DEFAULT_EDITOR "$CODEX_HOME"
  }

  updates+=(update-codex)
fi
