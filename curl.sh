#!/bin/sh

set -e

echo "$(date) ------------------------------------ Starting curl.sh:"

. /start.sh

echo "verifing start.sh (for varibles)"
if [ -x "/start.sh" ]; then
    echo "start.sh script verification successful."
else
    echo "CRITICAL: start.sh script not found. Please repull the image, or submit an issue at https://github.com/Sammeeeeeeee/Healthchecks-ping/issues"
fi

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

echo "Trying to CURL Healthchecks..."

if curl -s -o /dev/null -m "$TIMEOUT" --retry "$RETRY" "$URL"; then
    echo "CURL OK"
else
    echo "$(date) - CURL FAILED"
    exit 1
fi
echo "$(date) ------------------------------------ curl.sh END"