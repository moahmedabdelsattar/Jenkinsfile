pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // تأكد من أنك تسحب الفرع الصحيح
                git branch: 'dev',  // استخدم اسم الفرع الجديد هنا
                    url: 'https://github.com/moahmedabdelsattar/Jenkinsfile.git',
                    credentialsId: 'github'  // تأكد من أن بيانات الاعتماد صحيحة
            }
        }

        stage('Check Current Directory') {
            steps {
                // اعرض المسار الحالي والمحتويات للتحقق من مكان الملف
                sh 'pwd'  // عرض المسار الحالي
                sh 'ls -l'  // عرض الملفات في المجلد الحالي
            }
        }

        stage('Run Hello World') {
            steps {
                // منح صلاحيات التنفيذ للملف mo.sh
                sh 'chmod +x mo'  // منح صلاحيات التنفيذ للملف
                sh './mo'  // تنفيذ السكربت
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
