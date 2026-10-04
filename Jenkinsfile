
pipeline {
    agent any

    options {
        timestamps()
    }

    environment {
        PYTHON = 'C:\\Users\\Suhail.DESKTOP-0CIIIA7\\AppData\\Local\\Programs\\Python\\Python310\\python.exe'
        IMAGE_NAME = 'jenkins-calc-1-app'
        IMAGE_TAG = '1.0'
        DOCKERHUB_REPO = 'drek001/jenkins-calc-1-app'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                bat 'dir'
            }
        }

        stage('Check Python and Docker') {
            steps {
                bat '"%PYTHON%" --version'
                bat 'docker --version'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat '"%PYTHON%" -m pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                bat '"%PYTHON%" -m pytest -v'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKERHUB_USERNAME',
                        passwordVariable: 'DOCKERHUB_TOKEN'
                    )
                ]) {
                    powershell '''
                        try {
                            Write-Host "Logging in to Docker Hub..."

                            $env:DOCKERHUB_TOKEN | docker login `
                                --username $env:DOCKERHUB_USERNAME `
                                --password-stdin

                            if ($LASTEXITCODE -ne 0) {
                                throw "Docker Hub login failed"
                            }

                            Write-Host "Docker Hub login successful!"

                            $image = "$env:DOCKERHUB_USERNAME/jenkins-calc-1-app:1.0"

                            docker tag jenkins-calc-1-app:1.0 $image

                            if ($LASTEXITCODE -ne 0) {
                                throw "Docker image tagging failed"
                            }

                            docker push $image

                            if ($LASTEXITCODE -ne 0) {
                                throw "Docker image push failed"
                            }

                            Write-Host "Docker image pushed successfully!"
                        }
                        finally {
                            docker logout
                        }
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                bat 'docker run --rm drek001/jenkins-calc-1-app:1.0'
            }
        }

        stage('Run Application') {
            steps {
                bat '"%PYTHON%" app.py'
            }
        }
    }

    post {
        success {
            echo 'CI/CD Pipeline completed successfully!'
        }

        failure {
            echo 'CI/CD Pipeline failed. Check the console output.'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}