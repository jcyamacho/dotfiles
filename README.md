# dotfiles

Minimal yet powerful zsh configuration with **modular architecture** - install only the tools you need.

![Header](images/demo.gif)

## Quick Start

```bash
curl -sL https://raw.githubusercontent.com/jcyamacho/dotfiles/main/install.sh | sh
```

After installation, install tools on-demand:

```bash
install-node     # Node.js via fnm
install-rust     # Rust toolchain
install-code     # VS Code + utilities
update-all       # Update all installed tools
```

## Available Tools

| Tool | Install | Update | Features |
|------|---------|--------|----------|
| **Development Tools** ||||
| [VS Code](https://code.visualstudio.com/) | `install-code` |  | `c()` alias |
| [Cursor](https://www.cursor.com/) | `install-cursor` |  | `cr()` alias |
| [Zed](https://zed.dev/) | `install-zed` |  | `zd()` alias |
| **Languages** ||||
| [Go](https://go.dev/) | `install-go` |  | `gmt()`, `gmi()` + linter |
| [Rust](https://www.rust-lang.org/) | `install-rust` | `update-rust` | Via rustup |
| [Zig](https://ziglang.org/) | `install-zig` |  | Latest stable |
| [Ruby](https://www.ruby-lang.org/) | `install-rbenv` |  | Via rbenv |
| **JavaScript/TypeScript** ||||
| [Node.js](https://nodejs.org/) | `install-node` | `update-node` | Via fnm, auto LTS |
| [Bun](https://bun.sh/) | `install-bun` | `update-bun` | Fast runtime |
| [Deno](https://deno.com/) | `install-deno` | `update-deno` | Secure runtime |
| **Python** ||||
| [Python](https://www.python.org/) | `install-python` | `update-python` | UV + Ruff + Pyright, `act()` |
| **AI & CLI** ||||
| [Claude Code](https://www.anthropic.com/claude-code) | `install-claude` | `update-claude` | + agents & commands |
| [Gemini CLI](https://github.com/google/gemini-cli) | `install-gemini` | `update-gemini` | Google's AI CLI |
| [Fabric AI](https://github.com/danielmiessler/fabric) | `install-fabric-ai` |  | Patterns, `yt()` |
| [Ollama](https://ollama.com/) |  | `update-ollama-models` | Model updates |
| **Utilities** ||||
| [bat](https://github.com/sharkdp/bat) | `install-bat` |  | Enhanced cat |
| [GitHub CLI](https://cli.github.com/) | `install-gh` |  | + completions |
| [Fonts](https://github.com/ryanoasis/nerd-fonts) | `install-fonts` |  | Dev fonts |

## What's Included

### Core (Automatic)

- Oh-My-Zsh with essential plugins (git, syntax highlighting, autosuggestions)
- Starship prompt (plain text preset)
- direnv, zoxide, essential utilities
- Platform package managers

### Optional (On-Demand)

Each tool in `scripts/` provides:

- `install-<tool>` and `uninstall-<tool>` functions
- Consistent environment setup
- Update integration where supported
- Clean removal

## Usage Examples

```bash
# Install languages
install-rust && install-go && install-python

# Install editors
install-code && install-cursor

# Use convenience features
c ~/project          # Open in VS Code
gmt                  # Go mod tidy
act                  # Activate Python venv
yt <youtube-url>     # Process transcript

# Management
update-all           # Update everything
uninstall-cursor     # Clean removal
```

## Customization

### Configuration Commands

- `zcustomconfig` - Edit personal configurations (`~/.zcustom`)
- `zshconfig` - Edit main zsh configuration
- `starshipconfig` - Edit prompt configuration

### Custom Configuration

Create personal configs that won't be overridden:

```bash
zcustomconfig  # Opens ~/.zcustom in your editor

# Add your personal settings:
export MY_VAR="value"
alias my-cmd="command"
```

## Core Functions

- `exists <cmd>` - Check if command available
- `mkcd <dir>` - Create and cd to directory
- `update-dotfiles` - Refresh from repository
- `update-all` - Update all installed tools
- `brewup` - Update Homebrew packages (macOS)

## Why Modular?

- **Selective**: Install only what you need
- **Independent**: Each tool isolated, no conflicts
- **Maintainable**: Easy updates and removal
- **Transparent**: Clear understanding of what's installed

Perfect for developers who want control without complexity.
