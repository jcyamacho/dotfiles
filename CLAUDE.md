# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modular dotfiles system with an on-demand installation architecture. The system provides a curated set of development tools that can be installed and managed independently through shell functions.

## Core Architecture

### Entry Points
- `install.sh` - Main installation script that clones repo and sets up `.zshrc`
- `dotfiles.sh` - Core configuration sourced by `.zshrc`
- `dotfiles-mac.sh` / `dotfiles-linux.sh` - Platform-specific configurations
- `scripts/*.sh` - Individual tool installation/management scripts

### Key Components

**Main Configuration Flow:**
1. `dotfiles.sh` sets up core functions, oh-my-zsh, and starship prompt
2. Platform-specific file is sourced based on `$OSTYPE`
3. All scripts in `scripts/` directory are auto-sourced (filtered by platform)

**Global Variables:**
- `ZSHDOTFILES_DIR="$HOME/.dotfiles"` - Repository location
- `CUSTOM_TOOLS_DIR="$HOME/.local/bin"` - Local binaries path
- `DEFAULT_EDITOR="zed"` - Default editor for config functions
- `updates=()` - Array of update functions for `update-all`

**Core Functions:**
- `exists <cmd>` - Check if command is available
- `mkcd <dir>` - Create directory and cd into it
- `info <message>` - Display installation messages
- `warn <message>` - Display warning messages
- `reload` - Restart zsh session

## Tool Installation Pattern

Each script in `scripts/` follows a consistent pattern:

```bash
# Tool name and description
install-<tool>() {
  # Installation logic
  reload  # Always reload after installation
}

if exists <tool>; then
  update-<tool>() {
    # Update logic
  }
  
  uninstall-<tool>() {
    # Cleanup logic
    reload
  }
  
  # Tool-specific functions and aliases
  
  updates+=(update-<tool>)  # Add to global updates array
fi
```

## Common Commands

### Installation
```bash
# Install specific tools
install-node     # Node.js via fnm
install-rust     # Rust toolchain  
install-python   # Python via uv
install-go       # Go + golangci-lint
install-code     # VS Code
install-claude   # Claude Code CLI

# Update all installed tools
update-all
```

### Configuration Management
```bash
zshconfig        # Edit .zshrc
zcustomconfig    # Edit ~/.zcustom (personal config)
starshipconfig   # Edit starship.toml
update-dotfiles  # Refresh from repository
```

### Development Shortcuts
```bash
# Editor shortcuts
c <path>         # Open in VS Code (if installed)
cr <path>        # Open in Cursor (if installed) 
zd <path>        # Open in Zed (if installed)

# Language-specific
gmt              # go mod tidy
gmi              # go mod init with smart naming
act              # Activate Python venv (searches common locations)
yt <url>         # Process YouTube transcript with Fabric AI
```

## Platform Differences

**macOS (`dotfiles-mac.sh`):**
- Uses Homebrew as package manager
- `update-brew` function for Homebrew maintenance
- Scripts with `.mac.sh` suffix are macOS-only

**Linux (`dotfiles-linux.sh`):**  
- Uses system package managers
- Scripts with `.linux.sh` suffix are Linux-only

## Special Integrations

**Oh-My-Zsh:**
- Automatically installs with essential plugins (git, zsh-autosuggestions, zsh-syntax-highlighting)
- `update-omz` function for updates

**Starship Prompt:**
- Plain text preset by default
- Configuration stored in `~/.config/starship.toml`
- Preset shortcuts: `starship-preset-*`

**Claude Code:**
- Downloads community agents and commands from GitHub
- Stores in `~/.claude/agents/` and `~/.claude/commands/`
- Updates both CLI and community resources

## Development Guidelines

When modifying this system:

1. **Follow the modular pattern** - Each tool should be self-contained in its own script
2. **Use platform checks** - Suffix scripts with `.mac.sh` or `.linux.sh` for platform-specific code
3. **Add to updates array** - Include `updates+=(update-<tool>)` for tools that support updates
4. **Suppress output** - Use `> /dev/null` for installation commands to keep output clean
5. **Always reload** - Call `reload` after installations that modify shell environment
6. **Check dependencies** - Use `exists` function to verify prerequisites