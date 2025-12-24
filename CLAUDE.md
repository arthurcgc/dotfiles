# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for an ArcoLinux (Arch-based) system running i3 window manager with Polybar. These configs are designed to be symlinked from the home directory.

## Key Configurations

### i3 Window Manager (`.config/i3/config`)
- **Mod key**: Super (Mod4)
- **Navigation**: Vim-style (j/k/l/;) and arrow keys
- **Dual monitor setup**: DisplayPort-0 (left, workspaces 1-5) and HDMI-A-0 (right, workspaces 6-10)
- **Terminal**: Alacritty (`$mod+Return`)
- **Launcher**: Rofi (`$mod+d`)
- **Screenshots**: Flameshot (`$mod+p`)
- **Gaps**: i3-gaps enabled (1px inner/outer)
- **Compositor**: picom

### Polybar (`.config/polybar/`)
- Gotham color theme with Nord workspace accents
- Modules: i3 workspaces, Spotify, memory, CPU, backlight, arch/pacman updates, date
- Launched via `~/.config/polybar/launch.sh`
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

The README suggests symlinking from home:
```bash
ln -s dotfiles/.config/i3 ~/.config/i3
ln -s dotfiles/.tmux/.tmux.conf ~/.tmux.conf
# etc.
```

## When Modifying Configs

After changes to i3 config: `$mod+Shift+r` to restart i3 in-place
After changes to Polybar: Run `~/.config/polybar/launch.sh` or restart i3
