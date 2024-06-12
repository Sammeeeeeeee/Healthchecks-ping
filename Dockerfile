FROM alpine:latest

RUN apk --no-cache add curl

ADD *.sh /
RUN chmod +x /*.sh
RUN chmod u+w /*.sh

HEALTHCHECK --start-period=10s --interval=1m CMD /healthcheck.sh

ENTRYPOINT ["/start.sh"]