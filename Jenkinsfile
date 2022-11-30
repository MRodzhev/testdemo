pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhubb')
    }
    stages {
        stage('Access GitHub') {
           steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'jenkins-github', url: 'git@github.com:MRodzhev/testdemo.git']]])
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t rodzhev/firstdemo:latest .'
                sh 'docker build -t rodzhev/firstdemo:$BUILD_ID .'
            }
        }
        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push to Docker Hub') {
            steps {
        
                sh 'docker push rodzhev/firstdemo:latest'
            }
        }
        stage('SSH') {
            steps {
                script {
                    sh """
                    #!/bin/bash
                    ssh -T -o StrictHostKeyChecking=no ubuntu@52.58.113.240 << EOF
                    docker system prune -a -y
                    docker pull rodzhev/firstdemo:latest 
                    docker run -t -d --name firstdemo -p 5000:5000 rodzhev/firstdemo:latest
                    exit 0
                    << EOF
                    
                    """
                    
                    }
                }
            }
        }
    }
