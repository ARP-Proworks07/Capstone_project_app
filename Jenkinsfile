pipeline {
  agent any

  environment {
    SONARQUBE = 'sonarqube'           // name you used in Jenkins System config
    SONAR_TOKEN_CRED = 'sonar-token' // Jenkins credentials ID (secret text) with Sonar token
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/<your-username>/<your-repo>.git', branch: 'main'
      }
    }

    stage('Install') {
      steps {
        sh 'npm ci'
      }
    }

    stage('Build') {
      steps {
        sh 'npm run build || true'   // if you have a build step; adjust as needed
      }
    }

    stage('SonarQube analysis') {
      steps {
        withCredentials([string(credentialsId: env.SONAR_TOKEN_CRED, variable: 'SONAR_TOKEN')]) {
          withSonarQubeEnv(env.SONARQUBE) {
            // Use sonar-scanner via npx (no global install required)
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
        // Simple deploy: copy built static files into nginx html dir on host.
        // This assumes Jenkins agent has SSH deploy rights to host or runs on same host where /usr/share/nginx/html is mounted.
        sh 'cp -r ./dist/* /usr/share/nginx/html/ || true'
      }
    }
  }
}
