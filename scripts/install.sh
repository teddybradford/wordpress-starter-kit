#!/bin/bash

WP_DIR=wordpress

# Install WordPress
curl -o wordpress.zip https://wordpress.org/latest.zip
unzip -q -o wordpress.zip
rm wordpress.zip

# Install SQLite Integration plugin
curl -o sqlite-integration.zip https://downloads.wordpress.org/plugin/sqlite-integration.zip
unzip -q -o -d $WP_DIR/wp-content/plugins sqlite-integration.zip
rm sqlite-integration.zip
cp $WP_DIR/wp-content/plugins/sqlite-integration/db.php $WP_DIR/wp-content
cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php

# Install Timber plugin
curl -o timber-library.zip https://downloads.wordpress.org/plugin/timber-library.zip
unzip -q -o -d $WP_DIR/wp-content/plugins timber-library.zip
rm timber-library.zip

# Install development dependencies
npm install -g gulp
npm install
jspm install
