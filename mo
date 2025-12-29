pipeline {
    agent any  // Jenkins يشغّل الـ pipeline على أي Agent متاح

    stages {

        // مرحلة تنزيل الكود من Git
        stage('Checkout') {
            steps {
                git branch: 'dev',
                    url: 'https://github.com/moahmedabdelsattar/Jenkinsfile.git',
                    credentialsId: 'github'
            }
        }

        // مرحلة تشغيل السكربت
        stage('Run Script') {
            steps {
                sh 'chmod +x hello.sh'
                sh './hello.sh'
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
