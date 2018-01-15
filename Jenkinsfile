pipeline {
  agent any
  stages {
    stage('Stage01') {
      steps {
        svn 'asdasd'
        mail(subject: 'Subject', body: 'Body')
      }
    }
    stage('Stage02') {
      parallel {
        stage('Stage02') {
          steps {
            emailext(presendScript: 'asdsadasdad', subject: 'assad', body: 'asdaasd')
          }
        }
        stage('Stage02.1') {
          steps {
            readFile 'asdasd.txt'
          }
        }
      }
    }
  }
}