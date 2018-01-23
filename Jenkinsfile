pipeline {
  agent { dockerfile true }
  stages {
    stage('bundle install') {
      steps {
        sh 'bundle install'
      }
    }
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
}