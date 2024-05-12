#!/bin/sh

set -e

echo "$(date) - Start"

# Check if UUID is set and not empty
if [ -z "$UUID" ]; then
    echo "ERROR: No UUID provided in UUID variable."
    exit 1
fi

# Construct the URL
URL="https://hc-ping.com/$UUID"

# Perform the curl with optional options
if curl -m "$TIMEOUT" --retry "$RETRY" "$URL"; then
    echo "$(date) - OK"
else
    echo "$(date) - FAILED"
    exit 1
fi

echo "$(date) - End"
