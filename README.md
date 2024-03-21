# dotfiles (suzuki-toshihir0)

dotfiles by @suzuki-toshihir0

> [!CAUTION]
> When you run the Makefile, the existing dotfiles in the environment will be forcibly overwritten. Please take a backup if necessary.

# Getting Started

```sh
$ git clone https://github.com/suzuki-toshihir0/dotfiles.git
$ cd dotfiles
$ make
```

> [!TIP]
> The version of neovim that can be obtained with `sudo apt-get install neovim` is outdated, and some configurations may not work properly. I recommend obtaining the latest version of neovim via AppImage by following the instructions at https://github.com/neovim/neovim/blob/master/INSTALL.md#appimage-universal-linux-package.

## font
`HackGen Console NF` (https://github.com/yuru7/HackGen) is used as Nerd Font. To install, please execute the following.
```sh
$ cd font
$ make
```

## win32yank
This dotfiles is intended for a WSL2 environment. To share the clipboard between WSL and Windows, `win32yank` is used. To install, please follow the [installation guide](./win32yank/README.md).

## Coc configurations for NeoVim
To use semantic highlighting in NeoVim's Coc, you need to enable semantic tokens. Please copy and paste the settings in `.config/nvim/coc-settings.json` manually.

