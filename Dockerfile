# Use Node.js runtime
FROM node:20
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./
RUN npm ci --omit=dev

# Copy application files
COPY server.js app.js index.html ./

# Expose port
EXPOSE 5000

# Start the application
CMD ["npm", "start"]