CloudOps - Kubernetes CI/CD Monitoring Project
CloudOps is a complete DevOps project that integrates Git, Jenkins, Docker, Kubernetes (Minikube), and monitoring with Prometheus and Grafana. This project demonstrates a real-world CI/CD pipeline for deploying a static HTML website using Docker and Kubernetes, and setting up full monitoring for the cluster.

Project Stack
Git & GitHub for version control

Jenkins for CI/CD pipeline automation

Docker for containerization

Kubernetes (Minikube) for deployment

Prometheus & Grafana for monitoring

Helm for managing Kubernetes applications

Folder Structure
bash
Copy
Edit
CloudOps/
├── frontend/                 # Static HTML website (from Tooplate)
├── Dockerfile               # Builds Docker image using Nginx
├── jenkins/
│   └── Jenkinsfile          # Jenkins pipeline definition
Step-by-Step Guide
1. Clone the Repository
bash
Copy
Edit
git clone https://github.com/shadow846/CloudOps.git
cd CloudOps
2. Dockerize the Website
Dockerfile:

dockerfile
Copy
Edit
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY frontend/ /usr/share/nginx/html
Build and push:

bash
Copy
Edit
docker build -t goutham0842/cloudops-site .
docker login
docker push goutham0842/cloudops-site
3. Set Up Jenkins in Docker
bash
Copy
Edit
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts
Install plugins:

Git plugin

Docker plugin

Pipeline plugin

Credentials plugin

4. Jenkins CI/CD Pipeline
Jenkinsfile path: jenkins/Jenkinsfile

Pipeline stages:

Clone repo using proper credential checkout

Build Docker image

Push to Docker Hub

Jenkins project setup:

Pipeline from SCM

Git URL: https://github.com/shadow846/CloudOps.git

Credentials: GitHub username + token

Script path: jenkins/Jenkinsfile

5. Run Kubernetes Locally (Minikube)
bash
Copy
Edit
minikube start
Check status:

bash
Copy
Edit
minikube status
6. Pull Image and Deploy (Optional)
bash
Copy
Edit
docker pull goutham0842/cloudops-site
7. Install Monitoring Stack using Helm
Make sure Helm is installed and updated:

bash
Copy
Edit
helm version
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
Install Prometheus + Grafana:

bash
Copy
Edit
helm install kube-monitor prometheus-community/kube-prometheus-stack
Expose Grafana UI:

bash
Copy
Edit
kubectl patch svc kube-monitor-grafana -p '{"spec": {"type": "NodePort"}}'
minikube ip
Grafana URL:

php-template
Copy
Edit
http://<MINIKUBE_IP>:<NodePort>
Example:

cpp
Copy
Edit
http://192.168.58.2:31797
Get Grafana admin password:

bash
Copy
Edit
kubectl get secret kube-monitor-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo
Login user: admin

8. View Kubernetes Metrics
In Grafana:

Dashboard > Kubernetes / Compute Resources / Cluster

View CPU, memory usage, pod count, etc.

9. Fixes Implemented
Jenkins was updated to properly use git checkout with credentials to avoid not a git directory errors

Docker image build used Nginx Alpine for small image size

Minikube container issue resolved by rebuilding with correct image name and tagging

Grafana exposed using NodePort and accessed using minikube ip

All monitoring components verified as running using kubectl get pods -n default

Author
Created and maintained by shadow846

License
This project is open-source and available for educational and non-commercial use.
