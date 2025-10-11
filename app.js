const express = require('express');
const path = require('path');
const app = express();

// Serve static files
app.use(express.static('.'));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'ok', 
    message: 'This is the main app, this is a simple Node JS Application',
    timestamp: new Date().toISOString()
  });
});

module.exports = app;