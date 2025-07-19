# dotfiles

My minimal yet powerful (and fast) zsh configuration for development.

![Header](images/demo.gif)

## Getting started

### How to install

```bash
curl -sL https://raw.githubusercontent.com/jcyamacho/dotfiles/main/install.sh | sh
```

### Custom configuration

To add custom configurations that will not get overriden every time you update the .zshrc file, create a `~/.zcustom` file and it will be automatically sourced.

## What it does

The dotfiles are designed with a modular architecture:

- **Core tools** are automatically installed during setup
- **Optional tools** are available through individual scripts in the `scripts/` directory

### Core Installation (Automatic)

The main installation script automatically sets up:

#### Essential Shell Configuration

- **Oh-My-Zsh**: Framework with essential plugins
  - [gh](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gh): GitHub CLI auto completion
  - [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git): git aliases and functions
  - [gitignore](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitignore): gitignore.io integration
  - [zsh-navigation-tools](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zsh-navigation-tools): history navigation
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): syntax highlighting
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): command suggestions

#### Essential Development Tools

- **[Starship](https://starship.rs/)**: Minimal, fast, customizable prompt
- **[direnv](https://direnv.net/)**: Per-directory environment variables
- **[zoxide](https://github.com/ajeetdsouza/zoxide)**: Smarter cd command
- **Platform-specific package managers**: Homebrew (macOS) or equivalent (Linux)

#### Utility Functions & Aliases

- `mkcd`: create a folder and cd to it
- `exists`: check if a command exists
- `zshconfig`: edit ~/.zshrc
- `starshipconfig`: edit starship configuration
- `zcustomconfig`: edit custom configuration
- `cls`: clear terminal
- `ll`: detailed file listing
- `update-dotfiles`: update dotfiles from repository

### Optional Tools (On-Demand Installation)

All scripts in the `scripts/` directory are automatically sourced when you open a new terminal, making their installation commands immediately available. Each tool provides an `install-[tool-name]` command:

#### Language Runtimes & Package Managers

- **[Node.js](https://nodejs.org/)**: `install-fnm` or `install-node` - Fast Node Manager with LTS Node.js
- **[Bun](https://bun.sh/)**: `install-bun` - Modern JavaScript runtime
- **[Deno](https://deno.com/)**: `install-deno` - Secure TypeScript runtime
- **[Python](https://www.python.org/)**: `install-uv` or `install-python` - Modern Python package manager
- **[Rust](https://www.rust-lang.org/)**: `install-rust` - Rust toolchain via rustup
- **[Go](https://go.dev/)**: `install-go` - Go programming language with golangci-lint
- **[Ruby](https://www.ruby-lang.org/)**: `install-rbenv` - Ruby via rbenv
- **[Zig](https://ziglang.org/)**: `install-zig` - Zig programming language

#### Development Tools & Editors

- **[VS Code](https://code.visualstudio.com/)**: `install-code` - Microsoft Visual Studio Code
- **[Cursor](https://www.cursor.com/)**: `install-cursor` - AI-powered code editor
- **[Zed](https://zed.dev/)**: `install-zed` - High-performance code editor
- **[Claude Code CLI](https://www.anthropic.com/claude-code)**: `install-claude` - Anthropic's official CLI for Claude
- **[Gemini CLI](https://github.com/google/gemini-cli)**: `install-gemini` - Google's Gemini AI CLI
- **[GitHub CLI](https://cli.github.com/)**: `install-gh` - GitHub command-line tool

#### Utilities & Enhancements

- **[bat](https://github.com/sharkdp/bat)**: `install-bat` - Better cat with syntax highlighting
- **[Fonts](https://github.com/ryanoasis/nerd-fonts)**: `install-fonts` - Multiple developer fonts (Monaspace, Hack Nerd Font, JetBrains Mono)
- **[Fabric AI](https://github.com/danielmiessler/fabric)**: `install-fabric-ai` - AI-powered productivity tools

Each tool also provides an `uninstall-[tool-name]` command for clean removal.

**Usage Example:**

```bash
# Install Node.js via fnm
install-node

# Install Rust toolchain
install-rust

# Install Zed editor
install-zed
```

### Starship Configuration

The setup includes a custom starship configuration optimized for development workflows. It uses the [plain text preset](https://starship.rs/presets/plain-text.html) approach to avoid dependency on custom fonts while maintaining excellent readability and performance.
