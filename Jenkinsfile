@Library('jenkins-shared-library') _

pipeline {
  agent any

  environment {
    IMAGE_NAME    = "eronan22/database"
    IMAGE_TAG     = "git-${GIT_COMMIT[0..7]}"
  }

  stages {

    stage('PR Validation') {
        when {
            changeRequest()
        }
        steps {
            echo 'Running PR validation for database service'
            sh 'test -f init-scripts/init.sql || (echo "init.sql not found!" && exit 1)'
            sh 'test -f Dockerfile || (echo "Dockerfile not found!" && exit 1)'
            echo 'PR validation passed'
        }
    }

    stage('Validate') {
        steps {
            sh 'echo "Branch is: $BRANCH_NAME"'
            echo 'Validating init SQL script...'
            sh 'test -f init-scripts/init.sql || (echo "init.sql not found!" && exit 1)'
            }
        }

    stage('Container Build & Push') {
      when {
        anyOf {
            branch 'develop'
            branch 'main'
        }
      }
      steps {
        buildAndPush(IMAGE_NAME, IMAGE_TAG, 'dockerhub-credentials')
      }
    }

    stage('Security Scan') {
        when {
            anyOf {
                branch 'develop'
                branch 'main'
            }
        }
      steps {
        securityScan("${IMAGE_NAME}:${IMAGE_TAG}", 'image')
      }
    }

    // stage('Deploy to Staging') {
    //     when {
    //         branch 'release/*'
    //     }
    //     steps {
    //         deployToK8s('database', IMAGE_NAME, IMAGE_TAG, 'staging')
    //     }
    }
    // stage('Deploy to Dev') {
    //   when { branch 'develop' }
    //   steps {
    //     deployToK8s('database', IMAGE_NAME, IMAGE_TAG, 'dev')
    //   }
    // }

    // stage('Deploy to Production') {
    //     when { branch 'main' }
    //     steps {
    //         input message: 'Deploy to production?', ok: 'Approve'
    //         deployToK8s('database', IMAGE_NAME, IMAGE_TAG, 'prod')
    //     }
    // }
  //}

  post {
    success {
        echo "Database image ${IMAGE_NAME}:${IMAGE_TAG} built and pushed successfully"
    }
    failure {
        echo "Pipeline failed for database service"
    }
  }
}
