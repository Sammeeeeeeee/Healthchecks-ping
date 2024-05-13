# Specify a base image
FROM node:alpine

# Set the working directory to /usr/app
WORKDIR /usr/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY ./ ./

# Set up a default command to run the application
CMD [ "npm", "start" ]
