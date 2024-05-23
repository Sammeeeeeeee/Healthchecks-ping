#!/bin/sh

if [ -f "healthcheck.txt" ]; then
    content=$(<healthcheck.txt)
    if [ "$content" == "0" ]; then
        echo "HEALTHCHECK: Healthy"
        exit 0
    elif [ "$content" == "1" ]; then
        echo "HEALTHCHECK: Unhealthy"
        exit 1
    else
        echo "Invalid content in healthcheck file"
        exit 1
    fi
else
    echo "Healthcheck file does not exist. It will be created on first run"
fi