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
                    ssh -T -o StrictHostKeyChecking=no -i sshforservers.pem ubuntu@3.72.249.221
                    scp -v -o StrictHostKeyChecking=no index.html ubuntu@3.72.249.221:/var/www/html/ << EOF
                    docker rmi -f rodzhev/firstdemo:latest
                    docker pull rodzhev/firstdemo:latest
                    docker run -d -p 2222:80 --name demo rodzhev/firstdemo:latest
                    exit 0
                    << EOF
                    """
                    }
                }
            }
        }
    }
