# WordPress Development Kit

## Setup

Make a copy of `config.sh.sample` (located in the `scripts` directory) and name
it `config.sh`, then modify its configuration variables appropriately.

## Installation

Run `./scripts/install.sh` on a command line to install WordPress, core plugins,
and all necessary development dependencies.

## Development

Run `gulp` on a command line to start the development server and build tasks.

## Deployment

To automate the deployment of your WordPress theme to a remote server via SSH,
you should be able to simply run `./scripts/deploy.sh` on a command line to
sync your local build to the remote host specified in `config.sh`.
