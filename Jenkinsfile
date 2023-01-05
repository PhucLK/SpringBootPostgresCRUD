pipeline{
    agent any
    tools {
        maven 'MAVEN'
    }
    stages {
        stage('Build Maven') {
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '3fef490a-c252-4b84-8849-f0ee330d4316', url: 'https://github.com/PhucLK/SpringBootPostgresCRUD.git']])

                sh "mvn -Dmaven.test.failure.ignore=true clean package"

            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                  sh 'docker build -t 0357860030/spring-boot-jpa-postgresql .'
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {
                script {
                 withDockerRegistry(credentialsId: 'dockerhub') {
                     sh 'docker push 0357860030/spring-boot-jpa-postgresql'
                 }

                }
            }
        }
    }
}
