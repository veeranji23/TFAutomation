// Jenkinsfile
String credentialsId = 'awsCredentials'

pipeline {
    agent {
        node {
            label 'master'
        }
    }
    environment {
        terraform_version = '0.11.11'
        access_key = 'input_your_access_key'
        secret_key = 'input_your_secret_key'
    }
   
    stages {
        stage('checkout repo') {
            steps {
                git branch: "master",
                //url: 'https://github.com/aleti-pavan/terraform-ec2.git'
                url: 'https://github.com/veeranji23/TFAutomation.git'
            }
        }
        
        stage('terraform init') {
            steps {
                sh  """
                    pwd;ls;
                    terraform init ./5.with_outputs/
                    """
            }
        }
        stage('terraform plan') {
            steps {
                sh  """
                    terraform plan -var 'access_key=$access_key' -var 'secret_key=$secret_key' ./5.with_outputs/
                    ls -l ./5.with_outputs/
                    """
                 script {
                    timeout(time: 10, unit: 'MINUTES') {
                       input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
                    }
                }
            }
        }
        stage('terraform apply') {
            steps {
                sh  """
                    terraform apply -var 'access_key=$access_key' -var 'secret_key=$secret_key' -auto-approve ./5.with_outputs/
                    """
            }
        }
        
    }
}
