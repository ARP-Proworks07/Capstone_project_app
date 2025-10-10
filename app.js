const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('This is the main app, this is a simple Node JS Application');
});

module.exports = app;