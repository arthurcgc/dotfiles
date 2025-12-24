# dotfiles

Personal dotfiles for ArcoLinux (Arch-based) with i3 window manager.

## What's Included

| Config | Description |
|--------|-------------|
| `.config/i3` | i3 window manager (i3-gaps, picom, triple monitor) |
| `.config/polybar` | Status bar with Gotham theme |
| `.alacritty.toml` | Alacritty terminal |
| `.tmux` | Tmux with vi mode, kube-tmux status |
| `.bashrc` / `.zshrc` | Shell config with kubectl, gvm, pyenv |
| `.Xresources` | X11 settings (DPI, URxvt) |
| `.claude` | Claude Code global settings and custom agents |

## Prerequisites

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [i3-gaps](https://github.com/Airblader/i3)
- [polybar](https://github.com/polybar/polybar)
- [alacritty](https://github.com/alacritty/alacritty)
- [tmux](https://github.com/tmux/tmux)
- [picom](https://github.com/yshui/picom)
- [rofi](https://github.com/davatorium/rofi)

## Installation

```bash
git clone https://github.com/arthurcgc/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

This will:
1. Back up existing dotfiles to `~/.dotfiles.bak/`
2. Create symlinks to the repo

## Uninstall

```bash
cd ~/dotfiles
make uninstall
```

Restore backups from `~/.dotfiles.bak/` if needed.

## Key Bindings (i3)

| Key | Action |
|-----|--------|
| `$mod+Return` | Terminal (Alacritty) |
| `$mod+d` | Launcher (Rofi) |
| `$mod+q` | Kill window |
| `$mod+Shift+r` | Reload i3 |
| `$mod+p` | Screenshot (Flameshot) |
| `$mod+j/k/l/;` | Vim-style navigation |
