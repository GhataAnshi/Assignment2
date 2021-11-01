pipeline{
 environment {
        dockerImage = 'maven-application-assignment'
    }

   agent any 

    stages { 

        stage('Scan with SonarQube') {
            steps {

                bat 'mvn -f ./my-app/pom.xml package sonar:sonar -Dsonar.login=c3ecc1b7d6d7239c5681d0df589e97c52368ffd1'
                
            }
        }


        stage('Building our image') {
            steps {
                script {
                    dockerImage = docker.build dockerImage + ":%BUILD_NUMBER%" 
                }
            }
        }


        stage('Run Container'){
                steps {
                    echo "Steps that are followed: \n 1. Image built in above step is pushed to repository."
                    script{withCredentials([usernamePassword(credentialsId: 'gtaa', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    docker.withRegistry('', 'gtaa') {
                     sh " docker tag maven-application-assignment:${BUILD_NUMBER} gtaa/maven-application-assignment:1.0.0
                     sh "docker push gtaa/maven-application-assignment:1.0.0"
                    sh "docker run gtaa/maven-application-assignment:1.0.0"
                    }
                    }
                    }
                }
        }

    }
}
