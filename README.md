# WordPress Development Kit

## Installation

Run `./scripts/install.sh` on a command line to install WordPress and all
development dependencies.

## Development

Run `gulp` on a command line to start the development server and build tasks.

## Deployment

To automate the deployment of your WordPress theme to a remote server, first
rename `./scripts/deploy.sh.sample` to `./scripts/deploy.sh` and then modify its
configuration variables appropriately. Now you can run `./scripts/deploy.sh` on
a command line to deploy your local build to the specified remote server.
