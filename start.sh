#!/bin/sh

set -e

echo "Initializing start.sh:"

echo "Exporting UUID, TIMEOUT, and RETRY variables..."

export UUID=$UUID
export TIMEOUT=${TIMEOUT:-10}
export RETRY=${RETRY:-5}

echo "Timeout set to: $TIMEOUT seconds."
echo "Retry count set to: $RETRY times."

echo "verifing curl.sh"
if [ -x "/curl.sh" ]; then
    echo "curl.sh script verification successful."
    echo "Adding curl.sh to cron jobs..."
    echo "$CRON /curl.sh" >> /var/spool/cron/crontabs/root
    echo "CRON job successfully set with frequency: $CRON."
else
    echo "CRITICAL: curl.sh script not found. Please repull the image, or submit an issue at https://github.com/Sammeeeeeeee/Healthchecks-ping/issues"
fi

if [ "$WEB" = "true" ]; then
    echo "Starting nginx server..."
    nginx
    echo "Nginx server successfully started."
else 
    echo "No web server set. Start web UI with -e WEB="true"."
fi

echo "Web server status: OK."
echo "Running cron jobs in foreground. No further output expected from start.sh. Initialization complete."
crond -l 2 -f
echo "CRON execution failed. Check logs for details, or open an issue at https://github.com/Sammeeeeeeee/Healthchecks-ping/issues"
