
FROM alpine:latest

RUN apk --no-cache add curl nginx

ADD *.sh /
RUN chmod +x /*.sh

COPY index.html /usr/share/nginx/html/

COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/start.sh"]
CMD [""]