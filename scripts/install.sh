#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config variables
source "$DIR/config.sh"

# Install WordPress
if [ ! -d "wordpress" ]; then
  curl -o wordpress.zip https://wordpress.org/latest.zip
  unzip -q -o wordpress.zip
  rm wordpress.zip
fi

# Install SQLite Integration plugin
if [ ! -d "$WP_DIR/wp-content/plugins/sqlite-integration" ]; then
  curl -o sqlite-integration.zip https://downloads.wordpress.org/plugin/sqlite-integration.zip
  unzip -q -o -d "$WP_DIR/wp-content/plugins" sqlite-integration.zip
  rm sqlite-integration.zip
  cp "$WP_DIR/wp-content/plugins/sqlite-integration/db.php" "$WP_DIR/wp-content"
  cp "$WP_DIR/wp-config-sample.php" "$WP_DIR/wp-config.php"
fi

# Install Timber plugin
if [ ! -d "$WP_DIR/wp-content/plugins/timber-library" ]; then
  curl -o timber-library.zip https://downloads.wordpress.org/plugin/timber-library.zip
  unzip -q -o -d "$WP_DIR/wp-content/plugins" timber-library.zip
  rm timber-library.zip
fi

# Install ACF PRO plugin
if [ -n $ACF_KEY ]; then
  if [ ! -d "$WP_DIR/wp-content/plugins/advanced-custom-fields-pro" ]; then
    curl -o advanced-custom-fields-pro.zip "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=$ACF_KEY"
    unzip -q -o -d "$WP_DIR/wp-content/plugins" advanced-custom-fields-pro.zip
    rm advanced-custom-fields-pro.zip
  fi
fi

# Install Gulp
if ! hash gulp 2>/dev/null; then
  npm install -g gulp
fi

# Install development dependencies
if [ ! -d "node_modules" ]; then
  npm install
fi

# Install theme dependencies
if [ ! -d "jspm_packages" ]; then
  jspm install
fi
