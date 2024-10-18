# Use an official Node.js image from Docker Hub
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application's port
EXPOSE 3000

# Start the Node.js application
CMD ["npm", "start"]