#!/bin/bash
rclone sync ~/notes gdrive:notes --copy-links --log-level INFO
