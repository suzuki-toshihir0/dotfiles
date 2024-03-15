FONT_URL := https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip
FONT_DIR := /usr/local/share/fonts/hackgen
DOWNLOAD_DIR := $(CURDIR)/hackgen_temp

all: download unzip install clean

download:
	mkdir -p $(DOWNLOAD_DIR)
	curl -L $(FONT_URL) -o $(DOWNLOAD_DIR)/hackgen.zip

unzip:
	unzip $(DOWNLOAD_DIR)/hackgen.zip -d $(DOWNLOAD_DIR)

install:
	sudo mkdir -p $(FONT_DIR)
	sudo find $(DOWNLOAD_DIR) -name "*.ttf" -exec cp {} $(FONT_DIR) \;
	sudo fc-cache -fv

clean:
	rm -rf $(DOWNLOAD_DIR)

.PHONY: download unzip install clean
