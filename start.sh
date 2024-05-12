#!/bin/sh

set -e

apk --no-cache add curl

export UUID=$UUID
export TIMEOUT=${TIMEOUT:-10}
export RETRY=${RETRY:-5}

echo "Timeout set to: $TIMEOUT seconds"
echo "Retry count set to: $RETRY times"

echo "$CRON /curl.sh" > /var/spool/cron/crontabs/root
echo "CRON set to: $CRON"

if [ "$WEB" = "true" ]; then
    nginx -g "daemon off;"
    echo "Starting nginx..."
fi

crond -l 2 -f
echo "start.sh done..."