#!/bin/bash

# Change to the script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# Load config variables
source config.sh

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
WP="./wp-cli.phar --path="$WP_DIR""

# Download WordPress core
$WP core download

# Install SQlite Integration plugin
curl -O https://downloads.wordpress.org/plugin/sqlite-integration.zip
unzip -q sqlite-integration.zip -d "$WP_DIR/wp-content/plugins"
rm sqlite-integration.zip
cp "$WP_DIR/wp-content/plugins/sqlite-integration/db.php" "$WP_DIR/wp-content"

# Configure and install WordPress core
$WP core config --skip-check --dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASS" --extra-php <<PHP
define("WP_DEBUG", true);
define("WP_POST_REVISIONS", 50);
PHP
$WP core install --url="$WP_URL" --title="$WP_TITLE" --admin_name="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_EMAIL"
$WP rewrite structure "/%postname%"

# Install Advanced Custom Fields PRO plugin
if [ -n "$ACF_KEY" ]; then
  curl -o advanced-custom-fields-pro.zip "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=$ACF_KEY"
  unzip -q advanced-custom-fields-pro.zip -d "$WP_DIR/wp-content/plugins"
  rm advanced-custom-fields-pro.zip
fi

# Install and activate WordPress plugins
$WP plugin install rest-api
if [ -n "$ACF_KEY" ]; then
  $WP plugin install acf-to-wp-api
fi
$WP plugin install timber-library
$WP plugin update --all
$WP plugin activate --all

# Install Gulp
if ! hash gulp 2>/dev/null; then
  npm install -g gulp
fi

# Install Node modules
if [ ! -d "node_modules" ]; then
  npm install
fi

# Change back to the previous working directory
cd -
