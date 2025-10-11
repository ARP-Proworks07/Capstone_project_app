# Use Node.js runtime
FROM node:20-alpine
WORKDIR /usr/src/app

# Copy package files first for better caching
COPY package*.json ./

# Install production dependencies and create user in one RUN command
RUN npm ci --only=production && \
    npm cache clean --force && \
    addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copy application files
COPY server.js app.js ./

# Change ownership and switch to non-root user
RUN chown -R nodejs:nodejs /usr/src/app
USER nodejs

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:5000/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) }).on('error', () => process.exit(1))"

# Start the application
CMD ["npm", "start"]
