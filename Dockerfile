FROM alpine:latest

RUN apk --no-cache add curl

ADD *.sh /
RUN chmod +x /*.sh

HEALTHCHECK CMD --start-period=10s --interval=1m /healthcheck.sh

ENTRYPOINT ["/start.sh"]