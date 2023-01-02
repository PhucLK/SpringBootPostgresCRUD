pipeline {
//     agent any
    agent any
//     {label 'Built-In Node'}

    environment {
        DOCKER_HUB_LOGIN = credentials('dockerhub')
    }
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
            agent any
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