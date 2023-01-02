pipeline {
//     agent any
    agent {
        docker {
          image 'node:lts-buster-slim'
          args '-p 8989:8989'
        }
    }

//     environment {
//         DOCKER_HUB_LOGIN = credentials('283574a8-b551-4f94-880d-ff8607fe780e')
//     }
//     triggers {
//         pollSCM '* * * * *'
//     }

//     stage('Cloning our Git') {
//         steps {
//             git 'https://github.com/YourGithubAccount/YourGithubRepository.git'
//         }
//     }

    stages {
        stage('Build project') {
            steps {
                sh 'docker build -t spring-boot-jpa-postgresql .'
            }
        }
//         stage('Build Docker image') {
//             steps {
//                 sh 'docker run spring-boot-jpa-postgresql -e SPRING_PROFILES_ACTIVE='dev' -p 5000:5000'
//             }
//         }
//         stage('Push Docker image') {
//             steps {
//                  withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
//                     sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
//                     sh 'docker push spring-boot-jpa-postgresql'
//                  }
//             }
//         }
    }
}