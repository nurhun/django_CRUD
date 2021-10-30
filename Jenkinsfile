pipeline {

    agent any
    
    // Allow Github webhook integration.
    triggers {
        githubPush()
    }
    
    // Host IP to deploy docker containers on.
    environment {
        // HOST_IP = '18.232.163.7'
        // COMMIT_SHA = getCommitSHA()
        IMAGE_NAME = "nurhun/django_crud"
        // IMAGE_TAG = "v${BUILD_NUMBER}.${COMMIT_SHA}"
        IMAGE_TAG = "v0.2"
    }
    
    stages {
        
//         // If run as Pipeline script from inside Jenkins.
//         stage('Checkout') {
//             steps {
//                 git branch: '**', credentialsId: 'GitHub', url: 'https://github.com/nurhun/odoo_CICD.git'
//             }
//         }

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
//                     sh "docker tag nurhun/custom_odoo:v${BUILD_NUMBER}-${IMAGE_TAG} nurhun/custom_odoo:latest"
                    
                    withDockerRegistry(credentialsId: 'DockerHub') {
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            
                // sh "chmod +x commitSHA.sh"
                // sh "./commitSHA.sh ${IMAGE_TAG}"
                // stash(name: 'result', includes: 'deployments/tagged_deployment.yml')
            }
        }
        
        
        // // Deploy manifest files as deployment by SSH agent
        // stage('Deploy to kubernetes by ArgoCD') {
        //     steps {
        //         dir(path: env.BUILD_ID) {
        //             git credentialsId: 'GitHub', url: 'https://github.com/nurhun/odoo_CD.git'
        //             withCredentials([usernamePassword(credentialsId: 'GitHub', passwordVariable: 'PW', usernameVariable: 'USER')]) {
        //                 withCredentials([string(credentialsId: 'GitHub_email', variable: 'GITHUB_EMAIL')]) {
        //                     sh "git config --global user.email ${GitHub_email}"
                            
        //                     unstash(name: 'result')
        //                     sh "git add deployments/tagged_deployment.yml"
        //                     sh "git commit -m 'newer deployment image tag ${IMAGE_TAG}' "
        //                     sh "git remote set-url origin --add --push https://${USER}:${PW}@github.com/${USER}/odoo_CD.git"
        //                     sh "git push -u origin master"
        //                 }
        //             }
        //         }
        //     }
        // }
        
    }
}


// Get the commit SHA hash number to easily identify the exact commit where the image was build.
def getCommitSHA(){
    def sha  = sh script: 'git rev-parse --short HEAD', returnStdout: true
    return sha
}