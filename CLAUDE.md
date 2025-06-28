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

# Install HackGen Console NF font (Nerd Font with Japanese support)
cd font && make

# Enable rustup tab completion (if using Rust)
rustup completions zsh > ~/.zfunc/_rustup
```

### Makefile Targets
- `all`: Install all configurations (equivalent to: zsh tmux git nvim claude)
- `zsh`: Symlink .zshrc to home directory
- `tmux`: Symlink .tmux.conf to home directory
- `git`: Symlink git configs and auto-detect OS for platform-specific settings
- `nvim`: Create neovim config structure and symlink configurations
- `claude`: Symlink Claude user memory settings

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
   - Configures PATH for various development tools (npm global, cargo, etc.)
   - Custom tmux functions: `ide()` and `aide()` for development layouts
   - Repository navigation with `repos()` and `worktrees()` using fzf
   - Dynamic clipboard alias configuration (yank) based on platform detection

2. **Git Configuration (.gitconfig)**
   - Unified GitHub CLI credential helper for all authentication
   - Cross-platform compatibility (WSL auto-fallback to Windows Credential Manager)
   - Custom aliases using fzf for interactive operations
   - Clipboard integration: 
     - WSL: win32yank (ylf alias for copying commit hashes)
     - Linux: wl-copy (yank alias dynamically set in .zshrc)
   - Global gitignore via .gitignore_

3. **Neovim Configuration (.config/nvim/)**
   - Lua-based configuration with Japanese comments
   - Uses lazy.nvim as plugin manager
   - Mason-based LSP auto-installation (lua_ls, clangd, rust_analyzer, etc.)
   - Auto-formatting configuration for various languages
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

### Cross-Platform Compatibility

The configuration automatically adapts to different environments:
- **Git Authentication**: GitHub CLI credential helper with automatic WSL fallback to Windows Credential Manager
- **Clipboard Integration**: Environment-based alias configuration (win32yank vs wl-copy)
- **Shell Configuration**: Dynamic detection and configuration in .zshrc

### Private Configuration Management

- `.zshrc_private`: Source this file for sensitive configurations (API keys, tokens, personal settings)
- Not tracked in git for security
- Automatically sourced by .zshrc if present

### Important Notes

- **Forceful Overwriting**: The Makefile uses `ln -sf` which forcefully overwrites existing dotfiles without backup
- **Dependencies**: 
  - Required: neovim (latest via AppImage recommended), tmux, zsh with Oh My Zsh, fzf, ripgrep, gh (GitHub CLI)
  - Optional: win32yank (WSL), wl-clipboard (Linux), rustup (for Rust development)
- **Font**: HackGen Console NF provides Nerd Font icons and Japanese character support
- **Clipboard Integration**: 
  - WSL: win32yank enables clipboard sharing between WSL and Windows (see win32yank/README.md)
  - Linux: wl-clipboard for Wayland environments
- **PATH Configuration**: npm global packages automatically added to PATH (~/.npm-global/bin)