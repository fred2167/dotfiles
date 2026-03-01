# Agent Guide for `dotfiles`

## Purpose
This repository manages shell and developer environment configuration for macOS and Debian-based Linux machines using Dotbot.

## Core Workflow
1. Edit files in this repo.
2. Re-run installer from repo root:
   ```bash
   ./install
   ```
3. Reload shell and validate behavior:
   ```bash
   zsh -n zsh/.zshrc
   zsh -n zsh/zsh_tools_init.sh
   ```

## Key Files and What They Control
- `install`: Entry point. Syncs submodules and runs Dotbot with custom plugins.
- `install.conf.yaml`: Main install plan.
  - creates directories (`~/.local/bin`, `~/.claude/`)
  - creates symlinks (`~/.zshrc`, `~/.vimrc`, `~/.jq`, `~/.claude/CLAUDE.md`)
  - runs OS-specific package/install steps
- `zsh/.zshrc`: Main shell startup config.
- `zsh/zsh_tools_init.sh`: Plugin initialization wiring.
- `config/.alias.sh`: Aliases.
- `config/.fzf_config.sh`: fzf integration config.
- `machines/macrc.sh` and `machines/linuxrc.sh`: OS-specific runtime config.
- `tools/Brewfile`: macOS package list.

## OS-Specific Behavior
- macOS (`ifmacos` in `install.conf.yaml`)
  - Runs: `brew bundle --file=tools/Brewfile`
  - Links: `~/.hammerspoon/init.lua`
- Linux (`ifanylinux` + `ifdebian`)
  - Installs apt packages via custom Dotbot plugins
  - Installs fzf and zoxide
  - Installs a local `bat` deb package on Debian

## Editing Rules for Agents
- Prefer changing source files in this repo, not files under `$HOME` directly.
- Keep shell scripts POSIX-compatible unless file is clearly zsh-specific.
- Do not edit vendored/plugin submodule code unless explicitly requested:
  - `installer/dotbot/`
  - `installer/plugins/`
  - `zsh/plugins/`
  - `tools/github/fzf/`
- When changing install behavior, update `install.conf.yaml` first, then document in `README.md` if user-facing.

## Common Tasks
- Add a new symlinked config file:
  1. Add file under `config/` (or relevant directory).
  2. Add link target in `install.conf.yaml` under `link:`.
  3. Run `./install`.
- Add macOS package:
  1. Update `tools/Brewfile`.
  2. Run `./install` on macOS.
- Add Debian package:
  1. Update `install.conf.yaml` under `ifanylinux -> sudo -> apt`.
  2. Run `./install` on Debian-based Linux.

## Validation Checklist
- `zsh -n zsh/.zshrc` passes.
- `./install` completes without Dotbot errors.
- Expected symlinks exist (example: `~/.zshrc`, `~/.vimrc`).
- New aliases/functions load in a fresh shell.

## Notes
- `agents/CLAUDE.md` is linked to `~/.claude/CLAUDE.md` by the installer. Keep agent-facing guidance there if the user wants machine-wide Claude instructions.
