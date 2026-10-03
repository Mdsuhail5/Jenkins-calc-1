
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Getting project files from GitHub'
                bat 'dir'
            }
        }

        stage('Check Python') {
            steps {
                bat '"C:\\Users\\Suhail.DESKTOP-0CIIIA7\\AppData\\Local\\Programs\\Python\\Python310\\python.exe" --version'
            }
        }

        stage('Build') {
            steps {
                echo 'Installing dependencies'
                bat '"C:\\Users\\Suhail.DESKTOP-0CIIIA7\\AppData\\Local\\Programs\\Python\\Python310\\python.exe" -m pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests'
                bat '"C:\\Users\\Suhail.DESKTOP-0CIIIA7\\AppData\\Local\\Programs\\Python\\Python310\\python.exe" -m pytest -v'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t jenkins-calc-1-app:1.0 .'
            }
        }

        
        stage('Run Docker Container') {
            steps {
                echo 'Running application inside Docker...'
                bat 'docker run --rm jenkins-python-app:1.0'
            }
        }

        stage('Run Application') {
            steps {
                bat '"C:\\Users\\Suhail.DESKTOP-0CIIIA7\\AppData\\Local\\Programs\\Python\\Python310\\python.exe" app.py'
            }
        }
    }

    post {
        success {
            echo 'CI Pipeline completed successfully!'
        }
        failure {
            echo 'CI Pipeline failed!'
        }
    }
}
