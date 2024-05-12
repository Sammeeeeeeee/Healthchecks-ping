#!/bin/sh

set -e

echo "checking cron is running..."

if pgrep cron > /dev/null; then
    echo "Cron is OK"
else
    echo "Cron not OK. Starting cron..."
    crond -l 2 -f
    echo "Cron started."
fi

echo "Exporting UUID, TIMOUT and RETRY..."

export UUID=$UUID
export TIMEOUT=${TIMEOUT:-10}
export RETRY=${RETRY:-5}

echo "Timeout set to: $TIMEOUT seconds"
echo "Retry count set to: $RETRY times"

echo "$CRON /curl.sh" > /var/spool/cron/crontabs/root
echo "CRON set to: $CRON"

if [ "$WEB" = "true" ]; then
    echo "Starting nginx..."
    nginx -g "daemon off;"
    echo "Started nginx"
fi

echo "Web OK. Setting cron..."

crond -l 2 -f

echo "Cron set. start.sh done..."