#!/bin/bash

# Database
WP_DB_NAME=wordpress
WP_DB_USER=root
WP_DB_PASS=root

# General
WP_URL=localhost:8000
WP_TITLE="My WordPress Site"
WP_ADMIN_USER=root
WP_ADMIN_PASS=root
WP_ADMIN_EMAIL=root@wordpress.dev
WP_THEME=my-theme

# Remote server (for deployment)
REMOTE_HOST=
REMOTE_USER=

# Paths
WP_DIR=wordpress
WP_THEME_DIR="$WP_DIR/wp-content/themes/$WP_THEME"
REMOTE_WP_THEME_DIR=

# Advanced Custom Fields PRO license key
ACF_KEY=
