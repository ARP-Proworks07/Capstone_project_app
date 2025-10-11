pipeline {
  agent {
    docker {
      image 'node:20'
      args '-u root'
    }
  }

  environment {
    DOCKER_IMAGE = "my-nodejs-app"
  }

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  triggers {
    githubPush()
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/ARP-Proworks07/Capstone_project_app.git'
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'npm ci'
      }
    }

    stage('Run Tests') {
      steps {
        sh 'npm test --passWithNoTests || true'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh 'docker build -t $DOCKER_IMAGE .'
        }
      }
    }

    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv('sonar-local') {
          script {
            def scannerHome = tool 'SonarScanner'
            sh """
              "${scannerHome}/bin/sonar-scanner" \
                -Dsonar.projectKey=my-nodejs-app \
                -Dsonar.sources=. \
                -Dsonar.sourceEncoding=UTF-8 \
                -Dsonar.exclusions=node_modules/**
            """
          }
        }
      }
    }

    stage('Quality Gate') {
      steps {
        echo "Waiting for SonarQube analysis to complete..."
        sleep 15
        waitForQualityGate abortPipeline: true
      }
    }

    stage('Deploy to Minikube') {
      steps {
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
      }
    }
  }

  post {
    success {
      echo "✅ Deployment successful. Visit your app at http://<Minikube-IP>:<NodePort>"
    }
    failure {
      echo "❌ Build or quality gate failed. Check logs for details."
    }
  }
}