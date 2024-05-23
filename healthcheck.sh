#!/bin/s

if crontab -l 2>/dev/null | grep -q . ; then
  echo "Cronjob found, service is healthy."
else
  echo "No cronjob found, service is unhealthy."
  exit 1
fi