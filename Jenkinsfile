
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

        
        stage('Debug Docker Credentials') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKERHUB_USERNAME',
                        passwordVariable: 'DOCKERHUB_TOKEN'
                    )
                ]) {
                    powershell '''
                        Write-Host "Username received: [$env:DOCKERHUB_USERNAME]"
                        Write-Host "Token length: $($env:DOCKERHUB_TOKEN.Length)"

                        $bytes = [System.Text.Encoding]::UTF8.GetBytes($env:DOCKERHUB_TOKEN)
                        $sha = [System.Security.Cryptography.SHA256]::Create()
                        $hash = [BitConverter]::ToString($sha.ComputeHash($bytes)).Replace("-", "")

                        Write-Host "Token fingerprint: $hash"
                    '''
                }
            }
        }

        stage('Test Docker Hub Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKERHUB_USERNAME',
                        passwordVariable: 'DOCKERHUB_TOKEN'
                    )
                ]) {
                    powershell '''
                        Write-Host "Username: $env:DOCKERHUB_USERNAME"
                        Write-Host "Token length: $($env:DOCKERHUB_TOKEN.Length)"

                        Write-Host "Attempting Docker Hub login..."

                        $env:DOCKERHUB_TOKEN | docker login `
                            --username $env:DOCKERHUB_USERNAME `
                            --password-stdin

                        $loginExitCode = $LASTEXITCODE

                        Write-Host "Docker login exit code: $loginExitCode"

                        if ($loginExitCode -ne 0) {
                            throw "Docker Hub authentication failed."
                        }

                        Write-Host "Docker Hub authentication successful."
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
