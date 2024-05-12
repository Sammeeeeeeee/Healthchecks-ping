#!/bin/sh

set -e

echo "$(date) - Start"

# Check if UUID is set and not empty
if [ -z "$UUID" ]; then
    echo "ERROR: No UUID provided in UUID variable."
    exit 1
fi

# Check if CRON is set and not empty
if [ -z "$CRON" ]; then
    echo "ERROR: No CRON provided in CRON variable."
    exit 1
fi

# Validate CRON expression
if ! echo "$CRON" | crontab -l 2>/dev/null; then
    echo "ERROR: Invalid CRON expression."
    exit 1
fi

# Construct the URL
URL="https://hc-ping.com/$UUID"

# Perform the curl with optional options
if curl -s -m "$TIMEOUT" --retry "$RETRY" "$URL"; then
    echo "$(date) - OK"
else
    echo "$(date) - FAILED"
    exit 1
fi

echo "$(date) - End"
