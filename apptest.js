const request = require('supertest');
const app = require('./app');

test('GET / should return expected message', async () => {
  const res = await request(app).get('/');
  expect(res.statusCode).toBe(200);
  expect(res.text).toBe('This is the main app, this is a simple Node JS Application');
});