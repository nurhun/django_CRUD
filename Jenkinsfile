pipeline {

    agent any
    
    // Allow Github webhook integration.
    triggers {
        githubPush()
    }
    
    environment {
        IMAGE_NAME = "nurhun/django_crud"
        IMAGE_TAG = "v0.2"
    }
    
    stages {
        stage('Build') {
            steps {
                container('jnlp'){
                    sh "docker build . -t ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
        
        stage('Push') {
            steps {
                script {                  
                    withDockerRegistry(credentialsId: 'DockerHub') {
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
        
    }
}
