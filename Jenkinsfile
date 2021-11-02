def user
node {
  wrap([$class: 'BuildUser']) {
    user = env.BUILD_USER_ID
  }
}

pipeline {

   environment {
        dockerImage = 'maven-application-assignment'
        TF_WORKSPACE = "test"
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
                withSonarQubeEnv('sonarqube'){
                   sh 'mvn -f ./my-app/pom.xml sonar:sonar'
                }
            } 
        }

        stage('Initializing terraform') { 
            steps { 
                sh " ./${env.TF_WORKSPACE}/terraform init"
                sh "./${env.TF_WORKSPACE}/terraform plan "
            } 
        }

        stage('Building our image using terraform') { 
            steps { 
                sh "./${env.TF_WORKSPACE}/terraform apply -var aws_region=ap-south-1 "
            } 
        }

        stage('Push to ECR'){
                steps {
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
