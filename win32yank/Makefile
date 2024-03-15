URL := https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
FILE := win32yank-x64.zip
EXE := win32yank.exe

all: install

download:
	curl -L -o $(FILE) $(URL)
	unzip $(FILE)

install: download
	sudo mkdir -p ~/bin/
	sudo mv $(EXE) ~/bin/
	sudo chmod +x ~/bin/$(EXE)

clean:
	rm -f $(filter-out Makefile, $(wildcard *))
