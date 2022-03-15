#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /docker_rails/tmp/pids/server.pid

exec "$@"
