#!/bin/sh

set -e

echo "$(date) - Starting curl job:"

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
    echo "ERROR: Invalid CRON expression or CRON not defined."
    exit 1
else
    echo "CRON expression is OK. Next 3 scheduled runs:"
    for i in {1..3}; do
        echo "Run $i: $(date -d "$(date +'%Y-%m-%d %H:%M:%S')" --date="$(/usr/sbin/crontab -l | grep -E "$CRON" | /usr/bin/crontab -l | awk '{print $1, $2, $3, $4, $5}') +$((i * 60)) seconds" +'%Y-%m-%d %H:%M:%S')"
    done
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
