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
        stage('Push to Docker Registry'){
                steps {
                    script{withCredentials([usernamePassword(credentialsId: 'gtaa', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    docker.withRegistry('', 'gtaa') {
                    sh "docker login -u $dockerUser -p $dockerPassword"  
                    sh "docker pull gtaa/maven-application-assignment:1.0.0"
                    sh "docker run gtaa/maven-application-assignment:1.0.0"
                    }
					}
                    }
                }
        }

    }
}
