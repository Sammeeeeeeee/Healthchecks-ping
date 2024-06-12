#!/bin/sh

set -e

echo "$(date) ------------------------------------ Starting curl.sh:"

echo "verifing configurations.sh (for varibles)"
if [ -x "/configurations.sh" ]; then
    echo "configurations.sh script verification successful."
else
    echo "CRITICAL: configurations.sh script not found. Please repull the image, or submit an issue at https://github.com/Sammeeeeeeee/Healthchecks-ping/issues"
    exit 1
fi

. /configurations.sh

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
    echo "$CRON provided as CRON. Checking valid CRON..."
fi 

if ! crontab -l 2>/dev/null | grep -q "$CRON"; then
    echo "ERROR: Invalid CRON expression or CRON not defined. See docs at https://github.com/Sammeeeeeeee/Healthchecks-ping"
    exit 1
else
    echo "CRON is OK"
fi  

echo "Building URL..."

URL="https://hc-ping.com/$UUID"

echo "URL is OK"

echo "Trying to CURL Healthchecks.io..."

if curl -s -o /dev/null -m "$TIMEOUT" --retry "$RETRY" "$URL"; then
    echo "CURL OK. Updating healthcheck."
    if echo "0" > "Healthcheck.txt; then
        echo "Healthcheck updated successfully."
    else
        echo "Failed to write to Healthcheck.txt" >&2
        exit 1
    fi
else
    echo "$(date) - CURL FAILED. Updating healthcheck."
    if echo "1" > Healthcheck.txt; then
        echo "Healthcheck updated successfully."
    else
        echo "Failed to write to Healthcheck.txt" >&2
        exit 1
    fi
    exit 1
fi
echo "$(date) ------------------------------------ curl.sh END"
exit 0