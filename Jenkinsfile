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

        stage('Scan with SonarQube') { 
            steps { 
                withSonarQubeEnv('SonarQubeToken'){
                   bat 'mvn sonar:sonar'
                }
            } 
        }

        stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build dockerImage 
                }
            } 
        }

        stage('Push to ECR'){
                steps {
                    echo "Steps that are followed: \n 1. Image built in above step is pushed to repository."
                    script{
                    docker.withRegistry('941835213643.dkr.ecr.ap-south-1.amazonaws.com/assignment2-citiustech', 'ecr:ap-south-1:AWSCREDS') {
                        def image = docker.build('${dockerImage}')
                        image.push(${BUILD_NUMBER})
                    }
                    }
                }
        }


    }
}
