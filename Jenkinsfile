pipeline {
    agent any
    environment {
        IMG_NAME_MAIN = 'ahmedhassan55/react-prod'
        PORT_MAIN = '8040'
        CONTAINER_NAME_MAIN='react_prod'
        IMG_NAME_DEV = 'ahmedhassan55/react-dev'
        PORT_DEV = '8050'
        CONTAINER_NAME_DEV='react_dev'
    }

    stages {
        stage('Set vars') {
            steps {
                script {

                    if (env.BRANCH_NAME == 'dev') {
                        env.IMG_NAME=IMG_NAME_DEV
                        env.PORT=PORT_DEV
                        env.CONTAINER_NAME=CONTAINER_NAME_DEV
                    } else  {
                        env.IMG_NAME=IMG_NAME_MAIN
                        env.PORT=PORT_MAIN
                        env.CONTAINER_NAME=CONTAINER_NAME_MAIN
                    }
                    

                    
                }
            }
        }
        stage('build') {
            steps {
                echo 'start build'
              withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'user', passwordVariable: 'password')]) {
                
                sh "docker login -u $user -p $password"
                sh "docker build -t ${env.IMG_NAME} ."
                sh "docker push ${env.IMG_NAME}"
                
                
              }
            }
        }
        stage('deploy') {
            steps {
                echo 'start deploy'
              withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'user', passwordVariable: 'password')]) {

                sh "docker login -u $user -p $password"
                sh "docker pull ${env.IMG_NAME}"
                sh "docker stop ${env.CONTAINER_NAME} || true"
                sh "docker rm ${env.CONTAINER_NAME} || true"
                sh "docker run --name ${env.CONTAINER_NAME} -d -p ${env.PORT}:3000 ${env.IMG_NAME}"
                
                
              }
            }
        }
        stage('Print Yes') {
            steps {
                script {
                    if (currentBuild.resultIsBetterOrEqualTo('SUCCESS')) {
                        echo "Yes, the pipeline was successful!"
                    } else {
                        error "The pipeline did not succeed."
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up by deleting the cloned repository
            cleanWs()
        }
    }
}