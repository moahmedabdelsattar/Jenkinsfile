pipeline {
    agent any  // هذا يعني أن Jenkins يمكنه تشغيل الـ pipeline على أي جهاز متاح

    stages {
        // مرحلة تنزيل الملفات من مستودع Git
        stage('Checkout') {
            steps {
                git branch: 'dev',  // اختر الفرع الصحيح الذي يحتوي على الملف mo
                    url: 'https://github.com/moahmedabdelsattar/Jenkinsfile.git',
                    credentialsId: 'github'  // تأكد من أن بيانات الاعتماد صحيحة
            }
        }

        // مرحلة تشغيل السكربت
        stage('Run Script') {
            steps {
                // تأكد من منح صلاحيات التنفيذ للملف mo
                sh 'chmod +x mo'  // منح صلاحيات التنفيذ للملف

                // تنفيذ السكربت
                sh './mo'  // تشغيل السكربت
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'  // إذا نجح السكربت
        }
        failure {
            echo 'Pipeline failed!'  // إذا فشل السكربت
        }
    }
}
