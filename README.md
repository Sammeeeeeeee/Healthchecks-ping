<div
<p align="center">
  <h1>HEALTHCHECK CURL</h1>
  <h3>A simple and light container to curl healthchecks.io</h3>
  <br />
  <a href="https://github.com/Sammeeeeeeee/Healthchecks-ping/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=Bug">Bug Report</a>
  ·
  <a href="https://github.com/Sammeeeeeeee/Healthchecks-ping/issues/new?assignees=&labels=&projects=&template=feature_request.md&title=Feature+Request">Feature Request</a>
  ·
  <a href="https://github.com/Sammeeeeeeee/Healthchecks-ping/discussions/new/choose">Ask a Question</a>
  
[![GithubCI](https://github.com/Sammeeeeeeee/Healthchecks-ping/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Sammeeeeeeee/Healthchecks-ping/actions/workflows/docker-image.yml)
[![GitHub Release](https://img.shields.io/github/v/release/Sammeeeeeeee/Healthchecks-ping)](https://github.com/Sammeeeeeeee/Healthchecks-ping/releases)
[![GitHub Release](https://img.shields.io/github/v/release/Sammeeeeeeee/Healthchecks-ping)](https://github.com/Sammeeeeeeee/Healthchecks-ping/releases)
![GitHub Pre-Release](https://img.shields.io/github/v/release/Sammeeeeeeee/Healthchecks-ping?include_prereleases)
[![Docker Pulls](https://img.shields.io/docker/pulls/sammeeeee/healthcheck-curl)](https://hub.docker.com/r/sammeeeee/healthcheck-curl)
</p>
</div>


Docker image that runs a curl command based on cron, for [Healthchecks.io](https://healthchecks.io/), with only the UUID and a CRON timetable.
> [!IMPORTANT]  
> Please note I am in no way affiliated with Healthchecks.io, and this is not the recommended usage.  

# Usage

A [Docker](https://docs.docker.com/guides/get-started/) image is available on Docker Hub at [sammeeeee/healthcheck-curl](https://hub.docker.com/repository/docker/sammeeeee/healthcheck-curl/).

| Variable | Required | Default | Example | Description |
| --- | --- | --- | --- | --- |
| UUID | ✔️ | | `1eec3c1a-3ffc-4f20-9c55-31c47188ef49` | Your Healthchecks.io [UUID](https://healthchecks.io/docs). |
| CRON | ✔️ | | `*/5 * * * *` | How often you want to curl Healthchecks.io. You can use [crontab.guru](https://crontab.guru/) to help. |
| TIMEOUT | ❌ | `10` | `10` | How long until CURL [times out](https://everything.curl.dev/usingcurl/timeouts.html). |
| RETRY | ❌ | `5` | `5` | How many times to [retry](https://everything.curl.dev/usingcurl/downloads/retry.html). |

## Docker run
### Basic
```bash
docker run -e UUID="1eec3c1a-3ffc-4f20-9c55-31c47188ef49" -e CRON="*/5 * * * *" sammeeeee/healthcheck-curl:latest
```

### Recommended
You can add `-d` to detach, `--restart="always"` to always restart, and `--name=Healthchecks_Curl` to name it, as well as `-e TIMEOUT="10"` `-e RETRY="5"`:
```bash
docker run -d --name=Healthchecks_Curl -e UUID="1eec3c1a-3ffc-4f20-9c55-31c47188ec49" -e CRON="*/5 * * * *" -e TIMEOUT="10" -e RETRY="5" --restart="always" sammeeeee/healthcheck-curl:latest
```

## Docker Compose
### Basic
```yaml
version: '3'

services:
  healthcheck:
    image: sammeeeee/healthcheck-curl
    environment:
      - UUID=1eec3c1a-3ffc-4f20-9c55-31c47188ef49
      - CRON=*/5 * * * *
```

### Recommended
You can add `restart: always` to always restart, and `TIMEOUT="10"` `RETRY="5"`:

```yaml
version: '3'

services:
  Healthchecks_Curl:
    image: sammeeeee/healthcheck-curl:latest
    environment:
      - UUID=1eec3c1a-3ffc-4f20-9c55-31c47188ec49
      - CRON=*/5 * * * *
      - TIMEOUT=10
      - RETRY=5
    restart: always
```

## How it works:
At its core, it is simple. 
- Dockerfile:
  - Run from the latest Alpine image
  - Add curl
  - Give root permissions to the scripts
  - And set the entrypoint to `start.sh`
- start.sh
  - Exports the variables
  - Ensures the correct files exist
  - Adds the cronjob
  - Starts cron
- configurations.sh
  - Exports the variables, to be used in `curl.sh`
- curl.sh
  - Ensures configurations.sh exists
  - Ensures the variables are present and correct
  - Builds the URL 
  - Curls healthchecks.io with the selected variables
  - Exits
