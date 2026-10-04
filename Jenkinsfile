
pipeline {
    agent any

    environment {
        PYTHON = 'C:\\Users\\Suhail.DESKTOP-0CIIIA7\\AppData\\Local\\Programs\\Python\\Python310\\python.exe'
        DOCKER_IMAGE = 'drek001/jenkins-calc-1-app:1.0'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code from GitHub...'
                checkout scm
            }
        }

        stage('Check Tools') {
            steps {
                echo 'Checking Python and Docker versions...'

                bat '"%PYTHON%" --version'
                bat 'docker --version'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Python dependencies...'

                bat '"%PYTHON%" -m pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running Python unit tests...'

                bat '"%PYTHON%" -m pytest -v'
            }
        }

        stage('Pull Docker Image') {
            steps {
                echo 'Pulling Docker image from Docker Hub...'

                bat 'docker pull %DOCKER_IMAGE%'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'

                bat 'docker run --rm %DOCKER_IMAGE%'
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: Jenkins pipeline completed successfully!'
        }

        failure {
            echo 'FAILED: Jenkins pipeline encountered an error.'
        }

        always {
            echo 'Jenkins pipeline execution finished.'
        }
    }
}
