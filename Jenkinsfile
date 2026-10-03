pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Getting source code...'
            }
        }

        stage('Build') {
            steps {
                echo 'Installing dependencies...'
                bat 'py -m pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                echo 'Running test cases...'
                bat 'py -m pytest -v'
            }
        }

        stage('Complete') {
            steps {
                echo 'Project execution completed!'
            }
        }
    }
}