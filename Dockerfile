# Dockerfile
FROM alpine:latest

RUN apk --no-cache add curl nginx npm nodejs 

ADD *.sh /
RUN chmod +x /*.sh

COPY index.html script.js styles.css nginx.conf server.js /
RUN npm install express ws

ENTRYPOINT ["/start.sh"]
CMD [""]