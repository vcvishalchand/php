pipeline {
    agent any
    environment{
        IMAGE_NAME = 'vishalchand/php-docker:php$BUILD_NUMBER'
        DEV_SERVER_IP = 'ec2-user@172.31.36.254'
        TEST_SERVER_IP = 'ec2-user@172.31.0.151'
    }
    stages {
        stage("BUILD DOCKER IMAGE ON DEV_SERVER") {
            steps{
                script{
                    sshagent(['DEPLOY_SERVER']) { 
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                            echo "BUILDING THE DOCKER IMAGE"                             
                            sh "scp -o StrictHostKeyChecking=no -r docker-files/ ${DEV_SERVER_IP}:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER_IP} 'bash ~/docker-files/docker-script.sh'"
                            sh "ssh ${DEV_SERVER_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/docker-files/"   
                            sh "ssh ${DEV_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                            sh "ssh ${DEV_SERVER_IP} sudo docker push ${IMAGE_NAME}" 
                            //sh "ssh ${SERVER_IP} sudo docker-compose -f /home/ec2-user/docker-files/docker-compose.yml up -d"                      
                        }
                    }
                }
            }
        }
        stage('RUN PHP_APP ON TEST_SERVER'){
            steps{
                script{
                    sshagent(['DEPLOY_SERVER']) { 
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                            echo "BUILDING THE DOCKER IMAGE"                             
                            sh "scp -o StrictHostKeyChecking=no -r docker-files/ ${TEST_SERVER_IP}:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no ${TEST_SERVER_IP} 'bash ~/docker-files/docker-script.sh'"  
                            sh "ssh ${TEST_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                            sh "ssh ${TEST_SERVER_IP} bash /home/ec2-user/docker-files/docker-compose-script.sh ${IMAGE_NAME}"                                                 
                        }
                    }
                }
            }
        }
    }
}
