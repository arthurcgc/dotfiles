# Crons

Systemd user timers (Linux) and launchd plists (macOS). Source of truth lives here.

## Linux setup (systemd)

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

# First run: establish bisync baseline
rclone bisync ~/notes gdrive:notes --resync
```

## macOS setup (launchd)

```bash
# Copy script
cp sync-notes.sh ~/.local/bin/sync-notes.sh
chmod +x ~/.local/bin/sync-notes.sh

# Install launchd plist
cp sync-notes-mac.plist ~/Library/LaunchAgents/com.arthur.sync-notes.plist
launchctl load ~/Library/LaunchAgents/com.arthur.sync-notes.plist

# First run: establish bisync baseline
rclone bisync ~/notes gdrive:notes --resync
```

## Security

- No credentials stored here. rclone OAuth tokens live in `~/.config/rclone/rclone.conf` (not tracked).
- Scripts should never contain secrets — use environment variables or external config files.

## Timers

| Timer | Schedule | What |
|-------|----------|------|
| sync-notes | Every 30min | `rclone bisync ~/notes gdrive:notes` (conflict: newer wins) |
| sync-paperless | Every 30min | Export Paperless docs, then rclone bisync consume + export to GDrive |
