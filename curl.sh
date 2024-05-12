#!/bin/sh

set -e

echo "$(date) - Starting curl.sh"

if [ -z "$UUID" ]; then
    echo "ERROR: No UUID provided in UUID variable."
    exit 1
else
    echo "$UUID provided as UUID..."
fi

if [ -z "$CRON" ]; then
    echo "ERROR: No CRON provided in CRON variable."
    exit 1
else
    echo "$CRON is provided ia CRON..."
fi

if ! echo "$CRON" | crontab -l 2>/dev/null; then
    echo "ERROR: Invalid CRON expression."
    exit 1
else
    echo "$CRON is OK"
fi

echo "Building URL..."

URL="https://hc-ping.com/$UUID"

echo "URL is OK"

if curl -s -m -o /dev/null "$TIMEOUT" --retry "$RETRY" "$URL"; then
    echo "$(date) - CURL OK"
else
    echo "$(date) - CURL FAILED"
    exit 1
fi

echo "$(date) - curl.sh End"
