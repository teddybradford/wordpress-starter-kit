# WordPress Development Kit

## Configuration

Make a copy of `scripts/config-sample.sh` and name it `scripts/config.sh`, then set its
configuration variables appropriately.

## Installation

Run `./scripts/install-wordpress` on a command line to install WordPress and essential plugins.
Then run `npm install` to install all required development dependencies.

## Development

Run `npm start` on a command line to launch the development server and run the build tasks.

## Deployment

For automated deployment of the WordPress theme to a remote server via SSH, simply run
`./scripts/deploy.sh` on a command line and the local build should sync to the remote host
specified in `scripts/config.sh`.
