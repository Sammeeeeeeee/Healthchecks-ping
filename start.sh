#!/bin/sh

set -e

# Install curl if not already installed
apk --no-cache add curl

# Set environment variables
export UUID=$UUID
export TIMEOUT=${TIMEOUT:-10}
export RETRY=${RETRY:-5}

# Set up cron job
echo "$CRON /curl.sh" > /var/spool/cron/crontabs/root

# Run cron in foreground
crond -l 2 -f
