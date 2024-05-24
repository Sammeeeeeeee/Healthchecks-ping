#!/bin/sh

if [ -f "healthcheck.txt" ]; then
    content=$(cat healthcheck.txt)  
    content=$(echo "$content" | tr -d '\n')  

    if [ "$content" = "0" ]; then  
        echo "Curl script exited with a healthy status (0)"
        exit 0
    elif [ "$content" = "1" ]; then 
        echo "Curl script exited with a unhealthy status (1)"
        exit 1
    else
        echo "Invalid content in the healthcheck file"
        exit 1
    fi
else
    echo "Healthcheck file does not exist. It will be created on first curl"
fi
