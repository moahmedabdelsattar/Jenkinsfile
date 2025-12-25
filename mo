pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/moahmedabdelsattar/Jenkinsfile.git',
                    credentialsId: 'github'
            }
        }

        stage('Run Hello World') {
            steps {
                sh 'ls -l'
                sh 'chmod +x mo.sh'
                sh './mo.sh'
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
