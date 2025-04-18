# Dotfiles

A minimalist yet powerful development environment setup for macOS and Debian-based systems. This repository contains configuration files and tools that enhance your command-line experience with modern replacements for traditional Unix tools (like `ls`, `cat`, `find`) and essential development tools (Git, Vim, Zsh). The setup is automated through a simple installation script that handles dependencies and configurations based on your operating system.

## Features

- **Shell Configuration**
  - Zsh setup with Powerlevel10k theme
  - Custom aliases and functions
  - FZF integration for fuzzy finding

- **Development Tools**
  - Git configuration with delta for better diffs
  - Vim configuration
  - JQ configuration for JSON processing

- **Command Line Tools**
  - ripgrep (fast text search)
  - fd (find files)
  - bat (better cat)
  - eza (modern ls replacement)
  - tldr (simplified man pages)
  - tree (directory listing)
  - zoxide (smarter cd)
  - sd (find and replace)

## Installation

1. Clone the repository (shallow clone for faster download):
   ```bash
   git clone --recursive --depth 1 https://github.com/yourusername/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install
   ```

The installer will:
- Create symbolic links for configuration files
- Install required tools using the appropriate package manager (Homebrew for macOS, apt for Debian)
- Set up shell configurations
- Install additional tools and utilities

## Updating Submodules

To keep your dotfiles up to date with the latest changes in submodules:

```bash
# Update all submodules to their latest versions
git submodule update  --recursive --remote 
```

## Directory Structure

- `config/` - Configuration files for various tools
- `zsh/` - Zsh shell configuration and plugins
- `tools/` - Custom tools and utilities
- `shortcuts/` - Keyboard shortcuts and bindings
- `machines/` - Machine-specific configurations

## Requirements

- macOS or Debian-based Linux
- Git
- Zsh
- Homebrew (for macOS)
- sudo access (for package installation)

## Customization

You can customize the installation by modifying:
- `install.conf.yaml` - Main configuration file
- `config/` - Individual tool configurations
- `zsh/` - Shell customizations

## License

MIT License