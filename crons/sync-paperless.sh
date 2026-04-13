#!/bin/bash
# Export all documents from Paperless, then sync both consume and export to Google Drive
docker exec paperless document_exporter /usr/src/paperless/export --no-progress-bar
rclone sync ~/paperless/consume gdrive:paperless/consume --log-level INFO
rclone sync ~/paperless/export gdrive:paperless/export --log-level INFO
