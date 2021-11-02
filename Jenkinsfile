def user
node {
  wrap([$class: 'BuildUser']) {
    user = env.BUILD_USER_ID
  }
}

pipeline {
parameters {
    password (name: 'AWS_ACCESS_KEY_ID')
    password (name: 'AWS_SECRET_ACCESS_KEY')
  }
   environment {
        dockerImage = 'maven-application-assignment'
       aws_access_key_id = "${params.AWS_ACCESS_KEY_ID}"
        aws_secret_access_key = "${params.AWS_SECRET_ACCESS_KEY}"
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
            steps {withAWS(credentials:'AWS_Creds') { 
                sh " /usr/local/bin/terraform init"
                sh "/usr/local/bin/terraform plan -var aws_region=ap-south-1 "
            } }
        }

        stage('Building our image using terraform') { 
            steps { 
                sh "/usr/local/bin/terraform apply -var aws_region=ap-south-1 "
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
