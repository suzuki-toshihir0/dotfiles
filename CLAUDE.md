# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository supporting both WSL2 and Linux environments. It provides standardized development environment configurations with automatic platform detection and adaptation.

## Common Commands

### Installation
```bash
# Clone and install (WARNING: forcibly overwrites existing files)
git clone https://github.com/suzuki-toshihir0/dotfiles.git
cd dotfiles
make

# Install specific configurations
make zsh     # Zsh configuration only
make tmux    # Tmux configuration only
make git     # Git configuration only (auto-detects WSL/Linux)
make nvim    # Neovim configuration only
make claude  # Claude user memory configuration only

# Install HackGen Console NF font
cd font && make

# Enable rustup tab completion (if using Rust)
rustup completions zsh > ~/.zfunc/_rustup
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
   - Custom tmux functions: `ide()` and `aide()` for development layouts
   - Repository navigation with `repos()` and `worktrees()` using fzf

2. **Git Configuration (.gitconfig, .gitconfig_linux, .gitconfig_wsl)**
   - Platform auto-detection via `detect_os.sh`
   - WSL: Windows credential manager integration
   - Linux: libsecret credential helper
   - Custom aliases using fzf for interactive operations
   - Clipboard integration via win32yank (WSL only)

3. **Neovim Configuration (.config/nvim/)**
   - Lua-based configuration with Japanese comments
   - Uses lazy.nvim as plugin manager
   - Mason-based LSP auto-installation (lua_ls, clangd, rust_analyzer, etc.)
   - Auto-formatting configuration (C/C++ with .clang-format, Rust always)
   - CopilotChat integration with Japanese prompts
   - Plugin configurations in lua/plugins/

4. **Tmux Configuration (.tmux.conf)**
   - Mouse support enabled
   - True color support
   - Prefix key: Ctrl+a
   - Vim-like key bindings for pane navigation and copy mode

5. **WSL-Windows Integration**
   - win32yank for clipboard sharing between WSL and Windows
   - Git credential manager integration for seamless authentication

6. **Claude User Memory (.claude/CLAUDE.md)**
   - Language preference settings for Claude Code interactions
   - Communication style preferences (Japanese language)

### Platform Detection

The `detect_os.sh` script automatically determines if running in WSL or native Linux by checking `/proc/version` for Microsoft signatures. This enables automatic configuration switching for:
- Git credential helpers
- Clipboard integration
- Platform-specific paths

### Important Notes

- **Forceful Overwriting**: The Makefile uses `ln -sf` which forcefully overwrites existing dotfiles without backup
- **Privacy**: Create `.zshrc_private` for sensitive configurations (API keys, tokens)
- **Dependencies**: Requires neovim (latest via AppImage recommended), tmux, zsh with Oh My Zsh, fzf, ripgrep
- **Font**: HackGen Console NF provides Nerd Font icons and Japanese character support
- **Clipboard Integration**: win32yank enables clipboard sharing between WSL and Windows (see win32yank/README.md for installation)