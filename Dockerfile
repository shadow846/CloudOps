# Use Nginx as the base image
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy your frontend site into nginx directory
COPY frontend/ /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
