pipeline {
  agent any

  environment {
    SONARQUBE = 'sonarqube'           // Jenkins SonarQube server name
    SONAR_TOKEN_CRED = 'sonar-token' // Jenkins credential ID (secret text) for Sonar token
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install') {
      steps {
        sh 'npm ci'
      }
    }

    stage('Build') {
      steps {
        sh 'npm run build || true'
      }
    }

    stage('SonarQube analysis') {
      steps {
        withCredentials([string(credentialsId: env.SONAR_TOKEN_CRED, variable: 'SONAR_TOKEN')]) {
          withSonarQubeEnv(env.SONARQUBE) {
            sh '''
              npx -y sonar-scanner \
                -Dsonar.projectKey=node-app \
                -Dsonar.sources=. \
                -Dsonar.host.url=$SONAR_HOST_URL \
                -Dsonar.login=$SONAR_TOKEN
            '''
          }
        }
      }
    }

    stage('Wait for Quality Gate') {
      steps {
        timeout(time: 5, unit: 'MINUTES') {
          waitForQualityGate abortPipeline: true
        }
      }
    }

    stage('Deploy to nginx') {
      steps {
        // Adjust this to your environment; this example copies files to nginx html folder on the Jenkins host
        sh 'cp -r ./dist/* /usr/share/nginx/html/ || true'
      }
    }
  }

  post {
    success {
      echo "Pipeline completed successfully."
    }
    failure {
      echo "Pipeline failed."
    }
  }
}
