#!/bin/sh

set -e

echo "$(date) - Starting curl job:"

if [ -z "$UUID" ]; then
    echo "ERROR: No UUID provided in UUID variable."
    exit 1
else
    echo "$UUID provided as UUID..."

if [ -z "$CRON" ]; then
    echo "ERROR: No CRON provided in CRON variable."
    exit 1
else
    echo "$CRON provided as UUID. Checking valid CRON..."
fi

if ! crontab -l 2>/dev/null | grep -q "$CRON"; then
    echo "ERROR: Invalid CRON expression or CRON not defined."
    exit 1
else
    echo "$CRON is OK"
fi

echo "Building URL..."

URL="https://hc-ping.com/$UUID"

echo "URL is OK"

echo "Trying CURL.."

if curl -s -o /dev/null -m "$TIMEOUT" --retry "$RETRY" "$URL"; then
    echo "CURL OK"
else
    echo "$(date) - CURL FAILED"
    exit 1
fi

echo "$(date) - curl job End"
