#!/bin/sh

set -e

# Install curl if not already installed
apk --no-cache add curl

# Set environment variables
export UUID=$UUID
export CURL_TIMEOUT=${CURL_TIMEOUT:-10}
export CURL_RETRY=${CURL_RETRY:-5}

# Set up cron job
echo "$CRON_SCHEDULE /curl.sh" > /var/spool/cron/crontabs/root

# Run cron in foreground
crond -l 2 -f
