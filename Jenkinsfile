pipeline {
  agent { docker 'ruby:2.4.1' }
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