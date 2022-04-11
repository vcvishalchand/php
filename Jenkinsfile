pipeline {
    agent any
    environment{
        IMAGE_NAME = 'vishalchand/php-docker:php$BUILD_NUMBER'
    }
    stages {
        stage("Build docker image") {
            steps{
                script{
                    sshagent(['Test_server-Key']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                            echo "Building the docker image"  
                            sh "scp -o StrictHostKeyChecking=no docker-script.sh ec2-user@172.31.37.199:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.37.199 'bash ~/docker-script.sh'"
                            sh "ssh ec2-user@172.31.36.254 sudo docker build -t ${IMAGE_NAME} /home/ec2-user/php"   
                            sh "ssh ec2-user@172.31.36.254 sudo docker login -u $USERNAME -p $PASSWORD"
                            sh "ssh ec2-user@172.31.36.254 sudo docker push ${IMAGE_NAME}" 
                            //sh "ssh ec2-user@172.31.36.254 docker-compose -f docker-compose.yml up -d"                      
                        }
                    echo "Building the docker image"
                    }
                }
            }
        }
    }
}