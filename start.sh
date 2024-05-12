#!/bin/sh

set -e

apk --no-cache add curl

export UUID=$UUID
export TIMEOUT=${TIMEOUT:-10}
export RETRY=${RETRY:-5}

echo "Timeout set to: $TIMEOUT seconds"
echo "Retry count set to: $RETRY times"


# Set up cron job
echo "$CRON /curl.sh" > /var/spool/cron/crontabs/root

echo "CRON set to: $CRON"

crond -l 2 -f