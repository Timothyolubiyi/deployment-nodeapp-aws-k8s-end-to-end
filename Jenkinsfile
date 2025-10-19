pipeline {
  agent any
  
  tools {nodejs "node"}
  
  environment {

        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'eu-north-1'
  }
  parameters {
    choice choices: ['apply', 'destroy'], description: '''Choose your terraform action
        ''', name: 'action'
  } 
  stages {

    stage("GitHub git cloning") {
            steps {
                script {
                    //checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GITHUB_CREDENTIALS', url: 'https://github.com/clement2019/Deploy-NodeApp-to-AWS-EKS-using-Jenkins.git']])
                    git branch: 'main', url: 'https://github.com/Timothyolubiyi/deployment-nodeapp-aws-k8s-end-to-end.git' 
                }
            }
        }
     
    
    stage('Docker image building......') {
      steps {
        script {
          sh 'docker build -t smartgigsctf/node-app8.0 .'
        }
      }
    }
    stage('pushing Docker Image to DockerHub') {
      steps {
        script {
          withCredentials([string(credentialsId: 'DOCKERID', variable: 'DOCKER_PASSWORD')]){
            sh 'docker login -u smartgigsctf@gmail.com -p ${DOCKER_PASSWORD}'
          }
            //normally
            //sh 'docker push smartgigsctf/node-app:""$Build_ID""'
            sh 'docker push smartgigsctf/node-app8.0:latest'
        }
      }   
    }
    stage('Run teraform init'){
            steps{
                script{
                    dir('terraform'){

                         sh 'terraform init'
                        
                    }
                }
            }
        }
        stage('Run Terraform validate'){
            steps{

                script{

                    dir('terraform'){

                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('view Resources to be provisioned'){
            steps{

                script{

                    dir('terraform'){

                        sh 'terraform plan'
                    }
                    input(message: "Approve?", ok: "proceed")
                }
            }
        }

        stage('Provision Resources') {
            steps {
               
                script {
                    if (params.'action' == 'apply') {

                        echo "You have chosen to ${params.'action'} the resources"
                        dir('terraform'){
                            sh 'terraform $action --auto-approve'
                            sh 'aws eks describe-cluster --name my-eks-cluster22 --region eu-north-1'
                            sh ('aws eks update-kubeconfig --name my-eks-cluster22 --region eu-north-1')
                            
                            sh "kubectl apply -f deployment.yaml"
                           
                                
                    
                        }
                    }
                }
        

            }
        }
       
        stage('Destroy Resources') {
            steps {
               
                script {
                    if (params.'action' == 'destroy') {

                        echo "You have chosen to ${params.'action'} the resources"
                        dir('terraform'){
                            sh 'terraform $action --auto-approve'
                        
                        }
                    }
                }
        

            }
        }
    }
}
    