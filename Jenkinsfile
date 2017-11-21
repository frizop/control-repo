pipeline {
  agent any
  stages {
    stage('lint') {
      steps {
        sh '''#!/bin/bash
puppet-lint .'''
      }
    }
  }
}