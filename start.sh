#!/bin/sh

set -e

# Install curl if not already installed
apk --no-cache add curl

# Set environment variable
export UUID=$UUID

# Set up cron job
echo "$CRON /curl.sh" > /var/spool/cron/crontabs/root

# Run cron in foreground
crond -l 2 -f
