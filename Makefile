DOTFILES := $(shell pwd)
HOME_DIR := $(HOME)

# Files to symlink directly to ~
HOME_FILES := .alacritty.toml .bashrc .zshrc .Xresources .gtkrc-2.0

# Directories to symlink directly to ~
HOME_DIRS := .claude .tmux

# Directories inside .config to symlink
CONFIG_DIRS := autostart conky gtk-3.0 i3 polybar variety

# Files inside .config to symlink
CONFIG_FILES := mimeapps.list

.PHONY: all install uninstall backup help

all: help

help:
	@echo "Usage:"
	@echo "  make install   - Create symlinks (backs up existing files)"
	@echo "  make uninstall - Remove symlinks"
	@echo "  make backup    - Backup existing dotfiles to ~/.dotfiles.bak/"

install: backup
	@echo "Creating symlinks..."
	@mkdir -p $(HOME_DIR)/.config
	@# Home files
	@for f in $(HOME_FILES); do \
		if [ -L "$(HOME_DIR)/$$f" ]; then \
			rm "$(HOME_DIR)/$$f"; \
		fi; \
		ln -sf "$(DOTFILES)/$$f" "$(HOME_DIR)/$$f"; \
		echo "  $$f -> $(DOTFILES)/$$f"; \
	done
	@# Home directories
	@for d in $(HOME_DIRS); do \
		if [ -L "$(HOME_DIR)/$$d" ]; then \
			rm "$(HOME_DIR)/$$d"; \
		fi; \
		ln -sf "$(DOTFILES)/$$d" "$(HOME_DIR)/$$d"; \
		echo "  $$d -> $(DOTFILES)/$$d"; \
	done
	@# Tmux conf special case
	@if [ -L "$(HOME_DIR)/.tmux.conf" ]; then rm "$(HOME_DIR)/.tmux.conf"; fi
	@ln -sf "$(DOTFILES)/.tmux/.tmux.conf" "$(HOME_DIR)/.tmux.conf"
	@echo "  .tmux.conf -> $(DOTFILES)/.tmux/.tmux.conf"
	@# Config directories
	@for d in $(CONFIG_DIRS); do \
		if [ -L "$(HOME_DIR)/.config/$$d" ]; then \
			rm "$(HOME_DIR)/.config/$$d"; \
		fi; \
		ln -sf "$(DOTFILES)/.config/$$d" "$(HOME_DIR)/.config/$$d"; \
		echo "  .config/$$d -> $(DOTFILES)/.config/$$d"; \
	done
	@# Config files
	@for f in $(CONFIG_FILES); do \
		if [ -L "$(HOME_DIR)/.config/$$f" ]; then \
			rm "$(HOME_DIR)/.config/$$f"; \
		fi; \
		ln -sf "$(DOTFILES)/.config/$$f" "$(HOME_DIR)/.config/$$f"; \
		echo "  .config/$$f -> $(DOTFILES)/.config/$$f"; \
	done
	@echo "Done! Restart your shell or run: source ~/.bashrc"

backup:
	@mkdir -p $(HOME_DIR)/.dotfiles.bak
	@for f in $(HOME_FILES); do \
		if [ -e "$(HOME_DIR)/$$f" ] && [ ! -L "$(HOME_DIR)/$$f" ]; then \
			mv "$(HOME_DIR)/$$f" "$(HOME_DIR)/.dotfiles.bak/"; \
			echo "Backed up $$f"; \
		fi; \
	done
	@for d in $(HOME_DIRS); do \
		if [ -e "$(HOME_DIR)/$$d" ] && [ ! -L "$(HOME_DIR)/$$d" ]; then \
			mv "$(HOME_DIR)/$$d" "$(HOME_DIR)/.dotfiles.bak/"; \
			echo "Backed up $$d"; \
		fi; \
	done
	@if [ -e "$(HOME_DIR)/.tmux.conf" ] && [ ! -L "$(HOME_DIR)/.tmux.conf" ]; then \
		mv "$(HOME_DIR)/.tmux.conf" "$(HOME_DIR)/.dotfiles.bak/"; \
		echo "Backed up .tmux.conf"; \
	fi
	@for d in $(CONFIG_DIRS); do \
		if [ -e "$(HOME_DIR)/.config/$$d" ] && [ ! -L "$(HOME_DIR)/.config/$$d" ]; then \
			mv "$(HOME_DIR)/.config/$$d" "$(HOME_DIR)/.dotfiles.bak/"; \
			echo "Backed up .config/$$d"; \
		fi; \
	done
	@for f in $(CONFIG_FILES); do \
		if [ -e "$(HOME_DIR)/.config/$$f" ] && [ ! -L "$(HOME_DIR)/.config/$$f" ]; then \
			mv "$(HOME_DIR)/.config/$$f" "$(HOME_DIR)/.dotfiles.bak/"; \
			echo "Backed up .config/$$f"; \
		fi; \
	done

uninstall:
	@echo "Removing symlinks..."
	@for f in $(HOME_FILES); do \
		if [ -L "$(HOME_DIR)/$$f" ]; then \
			rm "$(HOME_DIR)/$$f"; \
			echo "  Removed $$f"; \
		fi; \
	done
	@for d in $(HOME_DIRS); do \
		if [ -L "$(HOME_DIR)/$$d" ]; then \
			rm "$(HOME_DIR)/$$d"; \
			echo "  Removed $$d"; \
		fi; \
	done
	@if [ -L "$(HOME_DIR)/.tmux.conf" ]; then \
		rm "$(HOME_DIR)/.tmux.conf"; \
		echo "  Removed .tmux.conf"; \
	fi
	@for d in $(CONFIG_DIRS); do \
		if [ -L "$(HOME_DIR)/.config/$$d" ]; then \
			rm "$(HOME_DIR)/.config/$$d"; \
			echo "  Removed .config/$$d"; \
		fi; \
	done
	@for f in $(CONFIG_FILES); do \
		if [ -L "$(HOME_DIR)/.config/$$f" ]; then \
			rm "$(HOME_DIR)/.config/$$f"; \
			echo "  Removed .config/$$f"; \
		fi; \
	done
	@echo "Done! You can restore backups from ~/.dotfiles.bak/ if needed"
