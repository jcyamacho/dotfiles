# Repository Guidelines

## Project Structure & Module Organization

- Core: `dotfiles.sh` (main), `install.sh` (bootstrap), `dotfiles-mac.sh` / `dotfiles-linux.sh` (platform setup).
- Modules: one tool per file in `scripts/` (`<tool>.sh`, or `<tool>.mac.sh` / `<tool>.linux.sh`). Keep scripts small and self‑contained.
- User config: `~/.zcustom` (open with `zcustomconfig`). Prompt: `~/.config/starship.toml` (open with `starshipconfig`).
- Entry shell: `.zshrc` loads only `dotfiles.sh`. Assets live under `images/`.
- Configuration flow: `dotfiles.sh` sets core + OMZ + starship; sources platform by `$OSTYPE`; auto‑sources `scripts/` filtered by suffix.
- Key env vars: `ZSHDOTFILES_DIR`, `CUSTOM_TOOLS_DIR`, `DEFAULT_EDITOR`; global `updates=()` collects update functions.

## Build, Run, and Development

- Install/refresh (idempotent): `./install.sh`.
- Develop without installing: `ZSHDOTFILES_DIR=$(pwd) zsh -ic 'source ./dotfiles.sh; exec zsh'`.
- Update all tools: `update-all`.
- Per‑tool lifecycle: `install-<tool>`, `update-<tool>`, `uninstall-<tool>` (e.g., `install-node`, `update-python`).
- macOS maintenance: `update-brew`.
- Convenience shortcuts (when installed): `c`/`cr`/`zd` (editors), `gmt`/`gmi` (Go), `act` (Python venv), `yt` (Fabric AI).

## Coding Style & Naming Conventions

- Formatting: 2‑space indent, LF, UTF‑8 (see `.editorconfig`).
- Filenames: `scripts/<name>.mac.sh` or `scripts/<name>.linux.sh`; cross‑platform as `scripts/<name>.sh`.
- Public functions use kebab‑case (`install-node`); internal helpers are snake_case prefixed with `_` (e.g., `_update_starship`).
- Use helpers: `exists`, `info`, `warn`. Prefer idempotent steps; suppress noisy output with `>/dev/null` when safe.
- Always `reload` after installs/uninstalls that affect the environment.
- If a tool supports updates, append `updates+=(update-<tool>)` in its script.

Tool pattern (abbrev):

```sh
install-foo() { info "Installing foo"; ...; reload; }
if exists foo; then
  update-foo(){ ...; }
  uninstall-foo(){ ...; reload; }
  updates+=(update-foo)
fi
```

## Testing Guidelines

- Static checks: `shellcheck scripts/*.sh dotfiles*.sh` and `zsh -n dotfiles.sh`.
- Manual: source in a clean subshell and probe behavior:
  `ZSHDOTFILES_DIR=$(pwd) zsh -ic 'source ./dotfiles.sh; exists starship && echo ok'`.
- Platform: provide `.mac.sh` and `.linux.sh` variants when needed; never cross‑source.

## Commit & Pull Request Guidelines

- Conventional Commits (`feat:`, `fix:`, `chore:`, `docs:`). Keep PRs scoped to one tool/concern.
- Include in PRs: purpose, affected scripts, OS tested, commands run, notable output/screenshots.
- Update `README.md` when commands, behavior, or usage change.

## Security & Configuration Tips

- Review external installers (`curl | sh`, Homebrew) before adding; pin versions where stability matters.
- Never overwrite user files without backups (see `.zshrc` handling in `install.sh`).
- Respect `CUSTOM_TOOLS_DIR` and `$PATH` ordering; avoid privileged operations; do not commit secrets.

## Integrations

- Oh My Zsh: auto-installed with essential plugins; update via `update-omz`.
- Starship: config at `~/.config/starship.toml`; preset aliases available (e.g., `starship-preset-plain-text`).
