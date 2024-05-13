# Dockerfile
FROM alpine:latest

RUN apk --no-cache add curl nginx nodejs

ADD *.sh /
RUN chmod +x /*.sh

COPY index.html script.js styles.css nginx.conf server.js /

ENTRYPOINT ["/start.sh"]
CMD [""]
