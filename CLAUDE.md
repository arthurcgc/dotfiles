# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for an ArcoLinux (Arch-based) system running i3 window manager with Polybar. Managed via Makefile for easy installation on clean systems.

## Key Configurations

### i3 Window Manager (`.config/i3/config`)
- **Mod key**: Super (Mod4)
- **Navigation**: Vim-style (j/k/l/;) and arrow keys
- **Monitor setup**: Supports 2 or 3 monitors (toggle by commenting/uncommenting in config)
  - 2-monitor: DP-2 @ 240Hz (left, WS 1-5), DP-1 @ 144Hz (right, WS 6-10)
  - 3-monitor: DP-2 primary (WS 1-4), HDMI-A-0 left (WS 5-7), DP-1 right (WS 8-10)
- **Terminal**: Alacritty (`$mod+Return`)
- **Launcher**: Rofi (`$mod+d`)
- **Screenshots**: Flameshot (`$mod+p`)
- **Gaps**: i3-gaps enabled (1px inner/outer)
- **Compositor**: picom

### Polybar (`.config/polybar/`)
- Gotham color theme with Nord workspace accents
- Modules: i3 workspaces, Spotify, memory, CPU, backlight, arch/pacman updates, date
- Launched via `~/.config/polybar/launch.sh` (auto-detects connected monitors)
- Custom scripts in `.config/polybar/scripts/` for Spotify, updates, weather, etc.

### Terminal Stack
- **Alacritty** (`.alacritty.toml`): Tokyo Night-ish color scheme, Hack font, auto-attaches to tmux
- **Tmux** (`.tmux/.tmux.conf`): Vi mode, mouse enabled, split with `|` and `-`, kube-tmux in status right

### Shell (`.bashrc`)
- kubectl completion with `k` alias
- Go (gvm), pyenv, custom PS1 with git branch
- Editor: nvim (aliased as `vim`)
- z for directory jumping

## Installation

```bash
git clone https://github.com/arthurcgc/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

This backs up existing files to `~/.dotfiles.bak/` and creates symlinks.

## When Modifying Configs

- After changes to i3 config: `$mod+Shift+r` to restart i3 in-place
- After changes to Polybar: Run `~/.config/polybar/launch.sh` or restart i3
