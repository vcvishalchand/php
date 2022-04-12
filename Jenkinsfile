pipeline {
    agent any
    environment{
        IMAGE_NAME = 'vishalchand/php-docker:php$BUILD_NUMBER'
        SERVER_IP = 'ec2-user@172.31.36.254'
    }
    stages {
        stage("Build docker image") {
            steps{
                script{
                    sshagent(['DEPLOY_SERVER']) { 
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                            echo "Building the docker image"  
                            sh "scp -o StrictHostKeyChecking=no docker-script.sh ${SERVER_IP}:/home/ec2-user"
                            sh "scp -o StrictHostKeyChecking=no -r ./ ${SERVER_IP}:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no ${SERVER_IP} 'bash ~/docker-script.sh'"
                            sh "ssh ${SERVER_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/php"   
                            sh "ssh ${SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
                            sh "ssh ${SERVER_IP} sudo docker push ${IMAGE_NAME}" 
                            //sh "ssh ec2-user@172.31.36.254 docker-compose -f docker-compose.yml up -d"                      
                        }
                    echo "Building the docker image"
                    }
                }
            }
        }
    }
}