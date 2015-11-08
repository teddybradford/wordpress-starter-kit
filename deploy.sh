#!/bin/bash

# Change to the script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# Load config variables
source config.sh

# Sync remote files with local ones
if [ -d "$LOCAL_WP_THEME_DIR" ]; then
  rsync -avz -e "ssh" "$LOCAL_WP_THEME_DIR" "$USER"@"$HOST":"$REMOTE_WP_THEME_DIR"
fi

# Change back to the previous working directory
cd -
