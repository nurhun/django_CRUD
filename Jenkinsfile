pipeline {

    agent any
    
    // Allow Github webhook integration.
    triggers {
        githubPush()
    }
    
    environment {
        IMAGE_NAME = "nurhun/django_crud"
        COMMIT_SHA = getCommitSHA()
        IMAGE_TAG = "v${BUILD_NUMBER}.${COMMIT_SHA}"
        // IMAGE_TAG = "v0.2"
    }
    
    stages {
        stage('Build') {
            steps {
                container('jnlp'){
                    sh "docker build . -t ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} nurhun/django_crud:latest "
                }
            }
        }

        stage('Push') {
            steps {
                script {                  
                    withDockerRegistry(credentialsId: 'DockerHub') {
                        sh "docker push ${IMAGE_NAME}"
                        // sh "docker tag  '${IMAGE_NAME}:${IMAGE_TAG}'  '${IMAGE_NAME}:latest'"
                        // sh "docker push ${IMAGE_NAME}"
                    }
                }
            }
        }
        
    }
}

// Get the commit SHA hash number to easily identify the exact commit where the image was build.
def getCommitSHA(){
    def sha  = sh script: 'git rev-parse --short HEAD', returnStdout: true
    return sha
}