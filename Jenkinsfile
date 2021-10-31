pipeline{
   environment { 
        registry = "assignemt2" 
        registryCredential = 'gtaa' 
        dockerImage = 'maven-application-assignment' 
    }

   agent any 

    stages { 


        stage('Building our image') { 

            steps { 

                script { 

                    dockerImage = docker.build dockerImage + ":%BUILD_NUMBER%" 

                }

            } 

        }
        stage('Execute Container') {


            steps {
                sh 'docker run maven-application:$BUILD_NUMBER'
            }
        }


    }
}
