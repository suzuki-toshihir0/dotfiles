all: zsh tmux

zsh:
	ln -sf $(PWD)/.zshrc $(HOME)/.zshrc

tmux:
	ln -sf $(PWD)/.tmux.conf $(HOME)/.tmux.conf