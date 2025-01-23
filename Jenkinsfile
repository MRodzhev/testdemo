pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker_creds')
    }
    stages {
        stage('Access GitHub') {
           steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Github_Creds', url: 'https://github.com/MRodzhev/testdemo']]])
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t rodzhev/secondattempt:$BUILD_ID .'
            }
        }
        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push to Docker Hub') {
            steps {
        
                sh 'docker push rodzhev/secondattempt:$BUILD_ID'
            }
        }
        stage('SSH') {
            steps {
                script {
                    sh """
                    #!/bin/bash
                    docker stop secondattempt
                    docker rm secondattempt
                    docker pull rodzhev/secondattempt:$BUILD_ID
                    docker run -t -d --name secondattempt -p 5001:5000 rodzhev/secondattempt:$BUILD_ID /bin/sh
                    << EOF
                    
                    """
                    
                    }
                }
            }
        }
    }
