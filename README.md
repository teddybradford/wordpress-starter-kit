# WordPress Development Kit

## Configuration

Make a copy of `config-sample.sh` and name it `config.sh`, then modify its
configuration variables appropriately.

## Installation

Run `./install.sh` on a command line to install WordPress, core plugins, and all
necessary development dependencies.

## Development

Run `gulp` on a command line to start the development server and build tasks.

## Deployment

For automated deployment of your WordPress theme to a remote server via SSH,
simply run `./deploy.sh` on a command line and your local build should sync to
the remote host specified in `config.sh`.
