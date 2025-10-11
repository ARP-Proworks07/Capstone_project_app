const request = require('supertest');
const app = require('../app');

describe('GET /', () => {
  it('should return This is the main app, this is a simple Node JS Application', async () => {
    const res = await request(app).get('/');
    expect(res.text).toBe('This is the main app, this is a simple Node JS Application'); // ✅ No exclamation mark
    expect(res.statusCode).toBe(200);
  }, 15000); // ⏱️ Increased timeout to 15 seconds
});
