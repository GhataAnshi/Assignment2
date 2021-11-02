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
  
      parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        //string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
      //  booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
  
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
                sh '/usr/local/bin/terraform workspace select ${environment}'
                sh ' /usr/local/bin/terraform init' 
                sh '/usr/local/bin/terraform plan '
            } 
        }

        stage('Building our image using terraform') { 
            steps { 
                sh '/usr/local/bin/terraform apply -var aws_region="ap-south-1" '
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
