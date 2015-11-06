#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config variables
source "$DIR/config.sh"

# Install WordPress
if [ ! -d "wordpress" ]; then
  curl -o wordpress.zip https://wordpress.org/latest.zip
  unzip -q -o wordpress.zip
  rm wordpress.zip
  cp -R wordpress/* "$WP_DIR"
  rm -rf wordpress
fi

function install_plugin {
  if [ ! -d "$WP_DIR/wp-content/plugins/$1" ]; then
    curl -o "$1.zip" $2
    unzip -q -o -d "$WP_DIR/wp-content/plugins" "$1.zip"
    rm "$1.zip"
  fi
}

# Install plugins
install_plugin sqlite-integration https://downloads.wordpress.org/plugin/sqlite-integration.zip
install_plugin timber-library https://downloads.wordpress.org/plugin/timber-library.zip
install_plugin post-types-order https://downloads.wordpress.org/plugin/post-types-order.zip
if [ -n $ACF_KEY ]; then
  install_plugin advanced-custom-fields-pro "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=$ACF_KEY"
fi

# Configure SQLite Integration
cp "$WP_DIR/wp-content/plugins/sqlite-integration/db.php" "$WP_DIR/wp-content"
cp "$WP_DIR/wp-config-sample.php" "$WP_DIR/wp-config.php"

# Install Gulp
if ! hash gulp 2>/dev/null; then
  npm install -g gulp
fi

# Install development dependencies
if [ ! -d "node_modules" ]; then
  npm install
fi
