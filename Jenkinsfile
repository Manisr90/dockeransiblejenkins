pipeline{
    
    agent {
    
        node{
            
            label 'mini'
            
            
        }
    }
    
     tools{
         
         maven 'maven'
         
        }
    
    
    stages {
        
        stage('Git Checkout'){
            
            steps{
                
                script{
                    
                    git branch: 'master', url: 'https://github.com/Manisr90/dockeransiblejenkins.git'
                }
            }
        }
        stage('UNIT testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn test'
                }
            }
        }
        stage('Integration testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven build'){
            
            steps{
                
                script{
                    
                    sh 'mvn clean install'
                }
            }
        }
        stage('Static code analysis'){
            
            steps{
                
                script{
                    
                  withSonarQubeEnv(credentialsId: 'sonartoken') {
                      
                          sh 'mvn clean package sonar:sonar'
                       }
                   }
                    
                }
            }
            stage('Quality Gate Status'){
                
                steps{
                    
                    script{
                        
                        waitForQualityGate abortPipeline: false, credentialsId: 'sonartoken'
                    }
                }
            }
        stage('Upload war to Nexus'){
            
            steps{
            
                script{                                       
                    def readPomVersion = readMavenPom file: 'pom.xml'
                    def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "skan-snapshot" : "skanjob"
                    nexusArtifactUploader artifacts: 
                        [[artifactId: 'dockeransible',
                          classifier: '',
                          file: 'target/dockeransible.war', 
                          type: 'war']], 
                        credentialsId: 'nexus-pwd', 
                        groupId: 'in.javahome',
                        nexusUrl: '3.10.174.182:8081', 
                        nexusVersion: 'nexus3',
                        protocol: 'http',
                        repository: 'nexusRepo', 
                        version: "${readPomVersion.version}"
                
                }
              }
        
          }
        
        stage('Docker image build'){
        
            steps{
            
                script{
                
                    sh 'docker build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker tag $JOB_NAME:v1.$BUILD_ID manikandan27/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker tag $JOB_NAME:v1.$BUILD_ID manikandan27/$JOB_NAME:latest'
                
                }
            
            }
        
        }
      }
}


