# Crons

Systemd user timers. Source of truth lives here — symlink or copy to activate.

## Setup

```bash
# Symlink units into systemd
ln -sf $(pwd)/sync-notes.timer ~/.config/systemd/user/sync-notes.timer
ln -sf $(pwd)/sync-notes.service ~/.config/systemd/user/sync-notes.service

# Copy script
cp sync-notes.sh ~/.local/bin/sync-notes.sh
chmod +x ~/.local/bin/sync-notes.sh

# Enable and start
systemctl --user daemon-reload
systemctl --user enable --now sync-notes.timer
```

## Security

- No credentials stored here. rclone OAuth tokens live in `~/.config/rclone/rclone.conf` (not tracked).
- Scripts should never contain secrets — use environment variables or external config files.

## Timers

| Timer | Schedule | What |
|-------|----------|------|
| sync-notes | Every 30min | `rclone sync ~/notes gdrive:notes` |
