# Tech Consulting Application

A Node.js web application for a technology consulting company that showcases services and provides contact functionality. The application is containerized using Docker and includes automated build and deployment scripts.

## Table of Contents

- [Tech Consulting Application](#tech-consulting-application)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the Application](#running-the-application)
    - [Local Development](#local-development)
  - [Testing](#testing)
  - [Docker Deployment](#docker-deployment)
    - [Building and Deploying](#building-and-deploying)
    - [Manual Docker Commands](#manual-docker-commands)
  - [Project Structure](#project-structure)
  - [API Endpoints](#api-endpoints)
    - [Home Page](#home-page)
    - [Services](#services)
    - [Contact Form](#contact-form)
    - [Submit Contact](#submit-contact)
  - [Error Handling](#error-handling)
  - [Environment Variables](#environment-variables)
  - [Contributing](#contributing)
  - [License](#license)

## Features

- Service catalog display
- Contact form functionality
- Responsive web interface
- Dockerized deployment
- Automated build and testing
- Error handling

## Prerequisites

- Node.js (v18 or higher)
- npm (Node Package Manager)
- Docker
- Docker Hub account (for deployment)

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Jenkins-freestyle-project
```

2. Install dependencies:
```bash
cd tech-consulting-app
npm install
```

## Running the Application

### Local Development

```bash
npm start
```
The application will be available at `http://localhost:3000`

![Local Development Screenshot]
[Place screenshot of running application here]

## Testing

Run the test suite:
```bash
npm test
```

![Test Results Screenshot]
[Place screenshot of test results here]

## Docker Deployment

### Building and Deploying

The application includes an automated build and deployment script:

```bash
./build-and-deploy.sh
```

This script will:
1. Install dependencies
2. Run tests
3. Build Docker image
4. Push to Docker Hub
5. Deploy container locally

![Docker Deployment Process]
[Place screenshot of successful deployment here]

### Manual Docker Commands

Build the image:
```bash
docker build -t franklynux/nodejs-app:v1.0 .
```

Run the container:
```bash
docker run -d -p 9000:9000 --name tech-consulting-app franklynux/nodejs-app:v1.0
```

## Project Structure

```
Jenkins-freestyle-project/
├── tech-consulting-app/
│   ├── app.js              # Main application file
│   ├── app.test.js         # Test suite
│   ├── package.json        # Dependencies and scripts
│   └── package-lock.json   # Locked dependencies
├── Dockerfile              # Docker configuration
├── build-and-deploy.sh     # Deployment script
├── verify.sh              # Verification script
└── README.md              # Documentation
```

## API Endpoints

### Home Page

- **URL:** `/`
- **Method:** `GET`
- **Description:** Landing page with navigation links

![Home Page Screenshot]
[Place screenshot of home page here]

### Services

- **URL:** `/services`
- **Method:** `GET`
- **Description:** Displays available consulting services

![Services Page Screenshot]
[Place screenshot of services page here]

### Contact Form

- **URL:** `/contact`
- **Method:** `GET`
- **Description:** Contact form for inquiries

![Contact Form Screenshot]
[Place screenshot of contact form here]

### Submit Contact

- **URL:** `/submit-contact`
- **Method:** `POST`
- **Description:** Handles contact form submissions
- **Body Parameters:**
  - `name`: String (required)
  - `email`: String (required)
  - `message`: String (required)

## Error Handling

The application includes built-in error handling for:
- 404 Not Found errors
- 500 Server errors
- Invalid form submissions

![Error Page Screenshot]
[Place screenshot of error page here]

## Environment Variables

- `PORT`: Application port (default: 3000)
- `DOCKER_USERNAME`: Docker Hub username (for deployment)
- `DOCKER_PASSWORD`: Docker Hub password (for deployment)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the ISC License - see the package.json file for details.
