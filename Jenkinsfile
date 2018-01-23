pipeline {
  agent { docker 'ruby:2.4.1' }
  stages {
    stage('build') {
      steps {
        sh 'bundle install'
      }
    }
    stage('Validate') {
      steps {
        sh 'bundle exec rake validate'
      }
    }
    stage('lint') {
      steps {
        sh 'bundle exec rake lint'
      }
    }
  }
}