all: zsh tmux git nvim

zsh:
	ln -sf $(PWD)/.zshrc $(HOME)/.zshrc

tmux:
	ln -sf $(PWD)/.tmux.conf $(HOME)/.tmux.conf

git:
	ln -s -f ${PWD}/.gitconfig ${HOME}/.gitconfig
	ln -s -f ${PWD}/.gitconfig_linux ${HOME}/.gitconfig_linux
	ln -s -f ${PWD}/.gitconfig_wsl ${HOME}/.gitconfig_wsl
	ln -s -f ${PWD}/.gitignore_ ${HOME}/.gitignore

nvim:
	mkdir -p $(HOME)/.config/nvim
	mkdir -p $(HOME)/.config/nvim/lua
	ln -sf $(PWD)/.config/nvim/init.lua $(HOME)/.config/nvim/init.lua
	find $(HOME)/.config/nvim/lua/plugins -maxdepth 1 -type l -delete
	ln -sf $(PWD)/.config/nvim/lua/plugins/ $(HOME)/.config/nvim/lua/
