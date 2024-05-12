[![Docker Image CI](https://github.com/Sammeeeeeeee/Healthchecks-ping/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Sammeeeeeeee/Healthchecks-ping/actions/workflows/docker-image.yml)

Docker image that runs a runs a curl command based on cron, for [Healthchecks.io](https://healthchecks.io/), with only the UUID and a CRON timetable. 
> [!IMPORTANT]  
>Please note I am in no way affiliated, and this is not the recommended usage. 

# Usage

A [docker](https://docs.docker.com/guides/get-started/) image is avalible on the docker hub at [sammeeeee/healthcheck-curl](https://hub.docker.com/repository/docker/sammeeeee/healthcheck-curl/). 

| Varible     | Required | Defualt                | Example                | Description                |
| ----------- | ---------| ---------------------- | ---------------------- | -------------------------- |
| UUID | &check; |  | `1eec3c1a-3ffc-4f20-9c55-31c47188ef49` | Your Healthchecks.io [UUID](https://healthchecks.io/docs). |
| CRON | &check;  |  | `/5 * * * *"` | How often you want to curl Healthchecks.io. You can use [crontab.guru](https://crontab.guru/) to help. |
| TIMEOUT | &cross; | `10` | `10` | How long until CURL [times out](https://everything.curl.dev/usingcurl/timeouts.html). |
| RETRY | &cross; | `5` | `5` | How many times to [retry](https://everything.curl.dev/usingcurl/downloads/retry.html). |
| WEB | &cross; | `false` | `true` | Simple web server showing details |

## Docker run
```bash
docker run -e UUID="1eec3c1a-3ffc-4f20-9c55-31c47188ef49" -e CRON="*/5 * * * *" -e TIMEOUT="10" -e RETRY="5" 
sammeeeee/healthcheck-curl
```
You can add `-d` to detach, `--restart="always" to always restart`, and `--name=Healthchecks_Curl` to name it. 

## Docker Compose
```yml
version: '3'

services:
  healthcheck:
    image: sammeeeee/healthcheck-curl
    environment:
      - UUID=1eec3c1a-3ffc-4f20-9c55-31c47188ef49
      - CRON=*/5 * * * *
      - TIMEOUT=10
      - RETRY=5
```
You can add `detach: true` to detach, `restart: always` to always restart, and `container_name: Healthchecks_Curl` to name it.