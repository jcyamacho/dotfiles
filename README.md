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

### Add functions

- `mkcd`: create a folder (if it does not exist) and cd to it.
- `exists`: check if a command exists.

### Install and configure OhMyZsh

Install and setup plugins from ohmyzsh:

- [gh](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gh): GitHub CLI auto completion.
- [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git): alias and functions for git.
- [gitignore](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitignore): use gitignore.io from the command line.
- [direnv](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/direnv): creates the Direnv hook.
- [zsh-navigation-tools](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zsh-navigation-tools): set of tools for navigating through history, etc.

Install custom plugins

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): syntax highlighting for the shell zsh.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): It suggests commands as you type based on history and completions.

### Add aliases

- `zshconfig`: open ~/.zshrc in vscode.
- `starshipconfig`: open ~/.config/starship.toml in vscode.
- `zcustomconfig`: open ~/.zconfig in vscode.
- `cls`: clear.
- `ll`: list all files (with colors).
- `update-dotfiles`: download latest dotfiles from git and install (does not source .zshrc)

### Install dev tools

Install (if not already installed):

- [direnv](https://direnv.net/): load and unload environment variables depending on the current directory.
- [nvm](https://github.com/nvm-sh/nvm): node version manager.
- [bun](https://bun.sh/): modern runtime for JavaScript and TypeScript.
- [deno](https://deno.land/): secure runtime for JavaScript and TypeScript.
- [cargo](https://www.rust-lang.org/): rust programming language and tools.
- [brew](https://brew.sh/): package manager for OSX.

### Install and configure Starship prompt

Install [starship](https://starship.rs/) prompt, a minimal, blazing-fast, and infinitely customizable prompt for any shell built in rust.

Configure starship with a custom starship.toml file inspired on the [plain text preset](https://starship.rs/presets/plain-text.html) to avoid the need of custom fonts and improve legibility. Some unnecessary plugins have been disabled to improve performance.
