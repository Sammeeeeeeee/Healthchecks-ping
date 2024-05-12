#!/bin/sh

set -e

echo "Starting start.sh:"

echo "Starting cron..."

crond -l 2

echo "Cron started. Checking cron is running..."

if pgrep cron > /dev/null; then
    echo "Cron is OK"
else
    echo "Cron not OK. Starting cron..."
    crond -l 2
    echo "Cron started."
fi

echo "Exporting UUID, TIMOUT and RETRY..."

export UUID=$UUID
export TIMEOUT=${TIMEOUT:-10}
export RETRY=${RETRY:-5}

echo "Timeout set to: $TIMEOUT seconds"
echo "Retry count set to: $RETRY times"

if [ -x "/curl.sh" ]; then
    echo "curl.sh script OK"
    echo "$CRON /curl.sh" >> /var/spool/cron/crontabs/root
    echo "CRON job set to: $CRON"
else
    echo "CRITICAL: curl.sh script not found."
fi

if [ "$WEB" = "true" ]; then
    echo "Starting nginx..."
    nginx -g "daemon off;"
    echo "Started nginx"
fi

echo "Web OK."
echo " Running cron in foreground. Expect no more output from start.sh. Start.sh OK"
crond -l 2 -f