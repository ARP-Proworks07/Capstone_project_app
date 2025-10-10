# Stage 1: Build and test
FROM node:18 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --include=dev
COPY . .
RUN npm test -- --coverage

# Stage 2: Production image
FROM node:18
WORKDIR /usr/src/app
# Copy package files for production install
COPY package*.json ./
RUN npm ci --omit=dev
# Copy only necessary application files
COPY server.js app.js ./
# Port used in the application
EXPOSE 5000
# Command to run the application
CMD ["npm", "start"]