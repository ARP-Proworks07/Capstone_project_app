# Node.js Capstone Project

A simple Node.js application with SonarQube integration and Kubernetes deployment.

## Project Overview

This project demonstrates CI/CD pipeline integration with:
- Jenkins for continuous integration
- SonarQube for code quality analysis
- Docker for containerization
- Kubernetes for deployment

## Prerequisites

- Node.js (v18 or higher)
- npm (v8 or higher)
- Docker
- Kubernetes (Minikube or any other distribution)
- Jenkins with SonarQube integration

## Installation

1. Clone this repository
2. Navigate to the project directory
3. Install dependencies:

```bash
npm install
```

## Configuration

The application uses environment variables for configuration. You can modify the `.env` file in the root directory:

```
PORT=3000
NODE_ENV=development
```

## Running the Application

### Development Mode

To run the application in development mode with auto-restart on file changes:

```bash
npm run dev
```

### Production Mode

To run the application in production mode:

```bash
npm start
```

## API Endpoints

### Home
- `GET /` - Welcome message
- `GET /health` - Health check endpoint

### Users
- `GET /users` - Get all users
- `GET /users/:id` - Get a user by ID
- `POST /users` - Create a new user

## Project Structure

```
simple-nodejs-app/
│
├── .env                  # Environment variables
├── app.js               # Main application file
├── package.json         # Project metadata and dependencies
│
└── routes/              # API routes
    ├── index.js         # Home routes
    └── users.js         # User routes
```

## License

ISC