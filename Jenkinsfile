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
        stage('Execute Cotainer') {
            agent {
                    docker {
                        image 'maven-application-assignment:%BUILD_NUMBER%'
                        args '-v %HOME%/.m2:/root/.m2'
                    }
                }


            steps {
                sh 'docker run maven-application:1.0.0'
            }
        }

        stage('Cleaning up') { 

            steps { 

                sh "docker rmi $registry:$BUILD_NUMBER" 

            }

        } 

    }
}
