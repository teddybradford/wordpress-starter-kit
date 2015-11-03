#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config variables
source "$DIR/config.sh"

# Sync remote files with local ones
rsync -avz -e "ssh" "$LOCAL_THEME_DIR" $USER@$HOST:"$REMOTE_THEME_DIR"
