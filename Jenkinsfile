def user
node {
  wrap([$class: 'BuildUser']) {
    user = env.BUILD_USER_ID
  }
}

pipeline {

   environment {
        dockerImage = 'maven-application-assignment'

    }

    agent any
  
  
    stages {

        stage('Code pull from Github') { 
            steps { 
                checkout scm
            } 
        }
        stage('Build Application') { 
            steps { 
                sh ' mvn -f ./my-app/pom.xml clean package'
            } 
        }

        /*stage('Scan with SonarQube') { 
            steps { 
                withSonarQubeEnv('sonarqube'){
                //   sh 'mvn -f ./my-app/pom.xml sonar:sonar'
                }
            } 
        }*/

        stage('Initializing terraform') { 
            steps {withAWS(credentials:'AWSCREDS') { 
                sh " /usr/local/bin/terraform init"
                sh "/usr/local/bin/terraform plan -var aws_region=ap-south-1 "
            } }
        }

       /* stage('Building docker image') { 
            steps { 
               script { 
                    dockerImage = docker.build "test-app-name" + ":%BUILD_NUMBER%"
                }
            } 
        }*/
       stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin https://941835213643.dkr.ecr.ap-south-1.amazonaws.com/assignment2-citiustech"
                }
                 
            }
        }
        stage('Push to ECR'){
                steps {
                    script{
                        def image = docker.build('${dockerImage}')
                        image.push('${dockerImage}:${BUILD_NUMBER}')
                    
                    }
                }
        }


    }
}
