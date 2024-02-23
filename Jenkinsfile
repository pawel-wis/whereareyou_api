pipeline{
    agent {
        docker { image 'ruby:3.3.0' }
    }
    environment {
        GEM_HOME = ".gems_storage"
    }
    stages {
        stage('Code checkout'){
            steps{
                git branch: 'main', credentialsId: '5e7ec9c7-ed07-48cf-aca9-ecdb9b862d43', url: 'https://github.com/pawel-wis/whereareyou_api/'
            }
        }
        stage('Install dependencies and master key'){
            steps{
                sh 'bundle'
                sh 'gem install rubocop'
                sh 'gem install brakeman'
                withCredentials([string(credentialsId: "RAILS_MASTER_KEY", variable: 'rails_key')]) {
                    sh 'echo ${rails_key} > config/master.key'
                }
            }
        }
        stage('Prepare databse'){
            steps{
                sh 'bin/rails db:create'
                sh 'bin/rails db:migrate'
            }
        }
        stage('Linst code and do security checks'){
            steps{
               sh 'rubocop'
               sh 'brakeman'
            }
        }
        stage('Rspec tests'){
            steps{
                sh 'RAILS_ENV=test bin/rails spec'
            }
        }
    }
    post {
        always {
            cleanWs()
            slackSend color: "green", message: "Build: ${env.JOB_NAME}\nStatus:${currentBuild.currentResult}"
        }
    }
}