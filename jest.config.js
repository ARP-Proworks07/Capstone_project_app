module.exports = {
  testEnvironment: 'node',
  collectCoverage: true,
  collectCoverageFrom: [
    'app.js',
    'server.js'
  ],
  coverageDirectory: 'coverage',
  testMatch: [
    '**/*.test.js'
  ]
};