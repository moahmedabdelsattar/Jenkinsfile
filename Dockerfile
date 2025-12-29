# Stage 1: Build Stage
FROM node:alpine AS build_stage
WORKDIR /app
COPY . .
RUN echo "Building the project..."

# Stage 2: Production Stage
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
# نسخ الملفات من مرحلة البناء إلى مجلد nginx
COPY --from=build_stage /app /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
