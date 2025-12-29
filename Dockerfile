  GNU nano 8.1                                                                                         Dockerfile                                                                                                   
# Stage 1: Build Stage (مرحلة البناء)
FROM node:alpine AS build_stage
WORKDIR /app
# هنا بنسخ ملفات المشروع عشان لو محتاج أعمل معالجة للـ CSS أو الصور
COPY . .
# لنفترض أننا سنقوم بضغط الملفات أو تجهيزها (خطوة اختيارية في المشاريع البسيطة)
RUN echo "Building the project..."

# Stage 2: Production Stage (مرحلة التشغيل النهائية)
FROM nginx:alpine
# تنظيف مجلد nginx الافتراضي
RUN rm -rf /usr/share/nginx/html/*
# السر هنا: بنسخ الملفات من المرحلة الأولى (build_stage) مش من جهازي مباشرة
COPY --from=build_stage /app /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
