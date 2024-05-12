# Use the Alpine Linux base image
FROM alpine:latest

# Install curl and nginx
RUN apk --no-cache add curl nginx dcron


# Add shell scripts
ADD *.sh /
RUN chmod +x /*.sh

# Copy the static HTML file
COPY index.html /usr/share/nginx/html/

# Set up nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Set the entrypoint and default command
ENTRYPOINT ["/start.sh"]
CMD [""]

