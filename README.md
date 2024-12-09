# Tech Consulting Application

A Node.js web application for a technology consulting company that showcases services and provides contact functionality. The application is containerized using Docker and includes automated build and deployment scripts.

## Related Projects
This project is part of a larger practice portfolio. You can also check out our e-commerce platform project at:
- [E-commerce Platform Practice](https://github.com/franklynux/ecommerce-platform-practice)

## Table of Contents
- [Tech Consulting Application](#tech-consulting-application)
  - [Related Projects](#related-projects)
  - [Table of Contents](#table-of-contents)
  - [Jenkins Setup](#jenkins-setup)
    - [Jenkins Server Setup](#jenkins-server-setup)
    - [Source Code Management Repository Integration](#source-code-management-repository-integration)
    - [Jenkins Freestyle Jobs for Build and Unit Tests](#jenkins-freestyle-jobs-for-build-and-unit-tests)
    - [Jenkins Pipeline for Running a Web Application](#jenkins-pipeline-for-running-a-web-application)
    - [Docker Image Creation and Registry Push](#docker-image-creation-and-registry-push)
  - [Security Measures](#security-measures)
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
  - [Author](#author)

## Jenkins Setup

### Jenkins Server Setup
- The Jenkins server is installed on an Amazon EC2 instance.
1. **Install Jenkins**:
   - Download and install Jenkins from the official website: [Jenkins Download](https://www.jenkins.io/download/)
   - Follow the installation instructions for your operating system.

2. **Plugin Installation and Configuration**:
   - Install necessary plugins:
     - Git Plugin
     - Docker Plugin
     - Pipeline Plugin
   - Configure plugins as needed.

3. **Security Measures**:
   - Enable security in Jenkins by configuring the "Manage Jenkins" > "Configure Global Security" section.
   - Set up user authentication and authorization.
   - Enable CSRF protection.
   - Configure the Jenkins URL to use HTTPS.

### Source Code Management Repository Integration
1. **Integrate with GitHub**:
   - Go to "Manage Jenkins" > "Manage Plugins" and install the GitHub plugin.
   - In the Jenkins dashboard, go to "Manage Jenkins" > "Configure System" and add your GitHub credentials.
   - Create a new Jenkins job and configure it to use your GitHub repository.

2. **Set Up Webhooks**:
   - In your GitHub repository, go to "Settings" > "Webhooks" and add a new webhook.
   - Set the payload URL to your Jenkins server's webhook endpoint (e.g., `http://your-jenkins-server/github-webhook/`).
   - Set the content type to `application/json` and select the events you want to trigger the webhook (e.g., push events).

### Jenkins Freestyle Jobs for Build and Unit Tests
1. **Create a Freestyle Job**:
   - Go to the Jenkins dashboard and click "New Item".
   - Enter a name for the job and select "Freestyle project".
   - In the "Source Code Management" section, select "Git" and enter your repository URL.
   - In the "Build Triggers" section, select "GitHub hook trigger for GITScm polling".
   - In the "Build" section, add build steps:
     - Execute shell: `npm install`
     - Execute shell: `npm test`

### Jenkins Pipeline for Running a Web Application
1. **Create a Pipeline Job**:
   - Go to the Jenkins dashboard and click "New Item".
   - Enter a name for the job and select "Pipeline".
   - In the "Pipeline" section, select "Pipeline script from SCM" and choose "Git".
   - Enter your repository URL and the branch to build.
   - In the "Script Path" field, enter the path to your Jenkinsfile (e.g., `Jenkinsfile`).

2. **Pipeline Script**:
   ```groovy
   pipeline {
       agent any
       stages {
           stage('Build') {
               steps {
                   sh 'npm install'
               }
           }
           stage('Test') {
               steps {
                   sh 'npm test'
               }
           }
           stage('Build Docker Image') {
               steps {
                   script {
                       def dockerImage = docker.build('franklynux/nodejs-app:v1.0')
                   }
               }
           }
           stage('Push Docker Image') {
               steps {
                   script {
                       docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                           def dockerImage = docker.build('franklynux/nodejs-app:v1.0')
                           dockerImage.push()
                       }
                   }
               }
           }
           stage('Deploy') {
               steps {
                   sh 'docker run -d -p 9000:9000 --name tech-consulting-app franklynux/nodejs-app:v1.0'
               }
           }
       }
   }
   ```

### Docker Image Creation and Registry Push
1. **Create Docker Image**:
   - Use the `Dockerfile` in the repository to build the Docker image.
   - Run the following command to build the image:
     ```bash
     docker build -t franklynux/nodejs-app:v1.0 .
     ```

2. **Run the Container**:
   - Run the following command to start the container:
     ```bash
     docker run -d -p 9000:9000 --name tech-consulting-app franklynux/nodejs-app:v1.0
     ```

3. **Push to Docker Hub**:
   - After building the image, you can push it to Docker Hub using:
     ```bash
     docker push franklynux/nodejs-app:v1.0
     ```

## Security Measures
- **Jenkins Server Security**:
  - Ensure Jenkins is running behind a reverse proxy with SSL termination.
  - Use strong passwords for Jenkins users and enable two-factor authentication if possible.
  - Regularly update Jenkins and its plugins to the latest versions to mitigate vulnerabilities.

- **Source Code Management Security**:
  - Use SSH keys for GitHub integration instead of username/password.
  - Limit access to the repository and use branch protection rules.

- **Pipeline Security**:
  - Use environment variables for sensitive information (e.g., Docker Hub credentials).
  - Regularly review and audit Jenkins jobs and pipelines for security best practices.

- **Docker Security**:
  - Use official base images and regularly scan images for vulnerabilities.
  - Limit container privileges and use user namespaces to enhance security.

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

1. Clone this repository:
```bash
git clone https://github.com/franklynux/Jenkins-freestyle-project.git
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

![Test Results Screenshot]
[Place screenshot of test results here]
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
├── build-and-deploy.sh     # Automated build and deployment script
├── verify.sh               # Script for verifying the deployment
├── images/                 # Directory for storing images used in the application
└── README.md               # Documentation
```

## API Endpoints

### Home Page
- **URL:** `/`

![Home Page Screenshot]
[Place screenshot of home page here]
- **Method:** `GET`
- **Description:** Landing page with navigation links

### Services
- **URL:** `/services`

![Services Page Screenshot]
[Place screenshot of services page here]
- **Method:** `GET`
- **Description:** Displays available consulting services

### Contact Form
- **URL:** `/contact`

![Contact Form Screenshot]
[Place screenshot of contact form here]
- **Method:** `GET`
- **Description:** Contact form for inquiries

### Submit Contact
- **URL:** `/submit-contact`

![Submit Contact Screenshot]
[Place screenshot of submit contact here]
- **Method:** `POST`
- **Description:** Handles contact form submissions
- **Body Parameters:**
  - `name`: String (required)
  - `email`: String (required)
  - `message`: String (required)

## Error Handling
The application includes built-in error handling for:

![Error Page Screenshot]
[Place screenshot of error page here]
- 404 Not Found errors
- 500 Server errors
- Invalid form submissions

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

## Author
[franklynux](https://github.com/franklynux)
