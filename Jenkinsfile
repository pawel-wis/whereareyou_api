pipeline {
    agent {
        docker { image 'ruby:3.3.0' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'ruby --version'
                sh 'rvm --version'
            }
        }
    }
}