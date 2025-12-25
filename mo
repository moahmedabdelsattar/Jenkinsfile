pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev',
                    url: 'https://github.com/moahmedabdelsattar/Jenkinsfile.git',
                    credentialsId: 'github'
            }
        }

        stage('Run Hello World') {
            steps {
                sh 'ls -l'
                sh 'chmod +x mo'
                sh './mo'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
