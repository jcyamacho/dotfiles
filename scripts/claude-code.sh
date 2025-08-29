# Claude Code CLI: https://www.anthropic.com/claude-code
export CLAUDE_CODE_PATH="$HOME/.claude"

install-claude() {
  if ! exists npm; then
    warning "npm is not installed"
    return 1
  fi

  info "Installing claude code..."
  npm install -g @anthropic-ai/claude-code@latest > /dev/null

  _update_claude_agents
  _update_commands
  reload
}

_update_claude_agents() {
    info "  - Downloading agents..."

    local agents_catalog="$CLAUDE_CODE_PATH/_agents"
    local agents_path="$CLAUDE_CODE_PATH/agents"
    mkdir -p $agents_path

    rm -fr $agents_catalog
    git clone https://github.com/wshobson/agents.git $agents_catalog > /dev/null

    cp -fv --  "$agents_catalog"/*.md "$agents_path"/ > /dev/null
    rm "$agents_path/README.md"
}

_update_commands() {
    info "  - Downloading commands..."

    local commands_catalog="$CLAUDE_CODE_PATH/_commands"
    local commands_path="$CLAUDE_CODE_PATH/commands"

    mkdir -p "$commands_path"/tools
    mkdir -p "$commands_path"/workflows

    rm -fr $commands_catalog
    git clone https://github.com/wshobson/commands.git $commands_catalog > /dev/null

    cp -fv --  "$commands_catalog"/tools/*.md "$commands_path"/tools/ > /dev/null
    cp -fv --  "$commands_catalog"/workflows/*.md "$commands_path"/workflows/ > /dev/null
}

if exists claude; then
  update-claude() {
    info "Updating claude..."

    npm install -g @anthropic-ai/claude-code@latest > /dev/null

    _update_claude_agents
    _update_commands
  }

  uninstall-claude() {
    info "Uninstalling claude..."
    npm uninstall -g @anthropic-ai/claude-code > /dev/null
    rm -rf $CLAUDE_CODE_PATH
    reload
  }

  updates+=(update-claude)
fi
