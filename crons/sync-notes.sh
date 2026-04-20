#!/bin/bash
rclone bisync ~/notes gdrive:notes \
  --conflict-resolve newer \
  --conflict-loser delete \
  --copy-links \
  --log-level INFO
