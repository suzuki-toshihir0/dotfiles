# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository designed for WSL2 (Windows Subsystem for Linux) environments. It provides standardized development environment configurations that can be quickly deployed on new systems.

## Common Commands

### Installation
```bash
# Install all dotfiles (WARNING: forcibly overwrites existing files)
make

# Install specific configurations
make zsh     # Zsh configuration only
make tmux    # Tmux configuration only
make git     # Git configuration only
make nvim    # Neovim configuration only

# Install HackGen Console NF font
cd font && make
```

### Development
```bash
# No specific build/test commands - this is a configuration repository
# Configurations take effect immediately after installation via symlinks
```

## Architecture and Structure

### Installation System
The repository uses GNU Make to create symbolic links from the repository to the user's home directory. This approach allows:
- Easy version control of configurations
- Quick updates by pulling latest changes
- Selective installation of components

### Key Components

1. **Shell Configuration (.zshrc)**
   - Uses Oh My Zsh with agnoster theme
   - Sources private configurations from `.zshrc_private` (not tracked)
   - Integrates with VSCode shell for Cline compatibility
   - Configures PATH for various development tools

2. **Git Configuration (.gitconfig, .gitconfig_linux, .gitconfig_wsl)**
   - Platform-specific credential management
   - Custom aliases using fzf for interactive operations
   - Clipboard integration via win32yank

3. **Neovim Configuration (.config/nvim/)**
   - Lua-based configuration with Japanese comments
   - Uses lazy.nvim as plugin manager
   - Plugin configurations in lua/plugins/

4. **WSL-Windows Integration**
   - win32yank for clipboard sharing between WSL and Windows
   - Git credential manager integration for seamless authentication

### Important Notes

- **Forceful Overwriting**: The Makefile uses `ln -sf` which forcefully overwrites existing dotfiles without backup
- **Privacy**: Create `.zshrc_private` for sensitive configurations (API keys, tokens)
- **Dependencies**: Requires neovim (latest via AppImage recommended), tmux, zsh with Oh My Zsh, fzf
- **Font**: HackGen Console NF provides Nerd Font icons and Japanese character support