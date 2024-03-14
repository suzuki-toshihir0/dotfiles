all: zsh tmux nvim

zsh:
	ln -sf $(PWD)/.zshrc $(HOME)/.zshrc

tmux:
	ln -sf $(PWD)/.tmux.conf $(HOME)/.tmux.conf

nvim:
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(PWD)/.config/nvim/init.lua $(HOME)/.config/nvim/init.lua
