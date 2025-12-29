pipeline {
    agent any
    
    environment {
        APP_NAME = 'web-app'
        REPO_URL = "https://github.com/moahmedabdelsattar/Jenkinsfile.git"
        // تعريف اسم الصورة مع التاج لتسهيل الاستخدام
        IMAGE_FULL_NAME = "${APP_NAME}:${BUILD_NUMBER}"
    }

    stages {
        stage('Getting Repo files') {
            steps {
                // تأكد أن متغير GIT_BRANCH معرف في Jenkins أو استبدله بـ 'main'
                git branch: 'main', credentialsId: 'github', url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_FULL_NAME} ."
                // عمل Tag إضافي كـ 'latest' للسهولة
                sh "docker tag ${IMAGE_FULL_NAME} ${APP_NAME}:latest"
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // 1. مسح أي حاوية قديمة بنفس الاسم إذا وجدت لتجنب الخطأ
                    try {
                        sh "docker stop ${APP_NAME} || true"
                        sh "docker rm ${APP_NAME} || true"
                    } catch (Exception e) {
                        echo "No existing container to remove."
                    }

                    // 2. تشغيل الحاوية الجديدة مع ربط البورت (مثلاً 8080)
                    // استبدل 80 بـ البورت اللي شغال عليه التطبيق جوا الـ Dockerfile
                    sh "docker run -d --name ${APP_NAME} -p 8080:80 ${IMAGE_FULL_NAME}"
                    
                    sh "docker ps"
                }
            }
        }
    }
    
    post {
        success {
            echo "Successfully deployed Build #${BUILD_NUMBER}"
        }
        cleanup {
            // اختيارياً: مسح الصور القديمة (Dangling images) لتوفير مساحة الهارد
            sh "docker image prune -f"
        }
    }
}
