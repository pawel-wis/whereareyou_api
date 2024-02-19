pipeline {
    agent {
        docker { image 'ruby:3.3.0' }
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh 'ruby --version'
                sh 'bundle install'
            }
        }
    }
}