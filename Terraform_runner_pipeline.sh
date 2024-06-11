pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
              git fetch
              sh 'git clone https://github.com/hermaneilze/D4ML.git'
              sh 'git checkout main'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
