pipeline {
  agent { dockerfile true }
  stages {
    stage('bundle install') {
      steps {
        sh 'bundle install'
      }
    }
    stage('Parallel Stage') {
      failFast true
      parallel {
        stage('rake validate') {
          steps {
            sh 'bundle exec rake validate'
          }
        }
        stage('rake lint') {
          steps {
            sh 'bundle exec rake lint'
          }
        }
      }
      stage('rake rubocop') {
        steps {
          sh 'bundle exec rake rubocop'
        }
      }
    }
  }
}