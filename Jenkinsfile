pipeline {
   agent any 
   
   environment {
       VALIDATION_FILE = "${WORKSPACE}/validations/validation_${BUILD_NUMBER}.txt"
   }
   
   stages{
      stage('Checkout') {
         steps {
            checkout([
               $class: 'GitSCM', 
               branches: [[name: '$BRANCH']], 
               doGenerateSubmoduleConfigurations: false, 
               extensions: [], submoduleCfg: [], 
               userRemoteConfigs: [[credentialsId: 'usuarioprueba', 
                                 url: '$URL_GITLAB']]])
            git branch: '$BRANCH', credentialsId: 'usuarioprueba', url: '$URL_GITLAB'
         }
         post {
            success {
               writeFile(file: "${VALIDATION_FILE}", text: 'Checkout: SUCCESS \n')
            }
            failure {
               writeFile(file: "${VALIDATION_FILE}", text: 'Checkout: FAILURE \n')
            }
         }
      }
      stage('Clean') {
         steps {
             sh "mvn -Dmaven.test.failure.ignore clean -P env-build-online,env-build-offline,env-build-ws"
         }
         post {
            success {
               writeFile(file: "${VALIDATION_FILE}", text: 'Clean: SUCCESS \n')
            }
            failure {
               writeFile(file: "${VALIDATION_FILE}", text: 'Clean: FAILURE \n')
            }
         }
      }
      stage('Versions') {
         steps {
            sh "mvn -Dmaven.test.failure.ignore org.codehaus.mojo:versions-maven-plugin:2.4:set -P env-build-online,env-build-offline,env-build-ws"
         }
         post {
            success {
               writeFile(file: "${VALIDATION_FILE}", text: 'Versions: SUCCESS \n')
            }
            failure {
               writeFile(file: "${VALIDATION_FILE}", text: 'Versions: FAILURE \n')
            }
         }
      }
      stage('Package Online') {
         steps {
            sh "mvn -Dmaven.test.failure.ignore package -P env-build-online"
         }
         post {
            success {
               writeFile(file: "${VALIDATION_FILE}", text: 'Package Online: SUCCESS \n')
            }
            failure {
               writeFile(file: "${VALIDATION_FILE}", text: 'Package Online: FAILURE \n')
            }
         }
      }
      stage('Package Offline') {
         steps {
            sh "mvn -Dmaven.test.failure.ignore package -P env-build-offline"
         }
         post {
            success {
               writeFile(file: "${VALIDATION_FILE}", text: 'Package Offline: SUCCESS \n')
            }
            failure {
               writeFile(file: "${VALIDATION_FILE}", text: 'Package Offline: FAILURE \n')
            }
         }
      }
      stage('Package WS') {
         steps {
            sh "mvn -Dmaven.test.failure.ignore package -P env-build-ws"
         }
         post {
            success {
               writeFile(file: "${VALIDATION_FILE}", text: 'Package WS: SUCCESS \n')
            }
            failure {
               writeFile(file: "${VALIDATION_FILE}", text: 'Package WS: FAILURE \n')
            }
         }
      }
   }

    post {

      success {
         emailext (
            to: "$RECIPIENTS",
            mimeType: 'text/html',
            subject: "SUCCESSFUL: Job ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
               body: "<p><b>SUCCESSFUL</b>: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p><p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p><p>VALIDATION_FILE:  " + readFile ('${VALIDATION_FILE}') + "</p>"
           )
      }

      failure {
         emailext (
            to: "$RECIPIENTS",
            mimeType: 'text/html',
            subject: "FAILED: Job ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
               body: "<p><b>FAILED</b>: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p><p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p><p>VALIDATION_FILE: " + readFile ('${VALIDATION_FILE}') + "</p>"
           )
      }

      unstable {
         emailext (
            to: "$RECIPIENTS",
            mimeType: 'text/html',
            subject: "UNSTABLE: Job ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
               body: "<p><b>UNSTABLE</b>: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p><p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p><p>VALIDATION_FILE: " + readFile ('${VALIDATION_FILE}') + "</p>"
           )
      }
   }
}
