Project Bedrock: EKS Microservices Deployment
Student ID: ALT-SOE-025-0383

Region: us-east-1 (N. Virginia)

📌 Project Overview
Project Bedrock is a production-grade deployment of a microservices-based Retail Store application on AWS. The project utilizes Terraform for Infrastructure as Code (IaC), Amazon EKS for container orchestration, and various AWS native services to ensure scalability, observability, and security.

Key Deliverables
Load Balancer URL: Visit Live Store

API Endpoint: Catalog API

GitHub Repository: IsaacOhiz/barakat-2025-capstone-0383

🏗️ Architecture
The infrastructure is composed of the following layers:

Networking: Custom VPC with 2 public and 2 private subnets across us-east-1a and us-east-1b.

Compute: EKS Managed Node Group utilizing t3.medium instances to provide sufficient memory (4GiB per node) for the service mesh.

Storage: S3 Bucket (bedrock-assets-0383) for static asset management.

Serverless: Lambda function (bedrock-asset-processor) triggered by S3 events.

Security: IAM OIDC provider for Service Accounts and RBAC-based view-only access for developers.

🛠️ Technical Standards & Compliance
This project strictly adheres to the naming and tagging conventions required for automated grading:

Resource Tagging: Project: barakat-2025-capstone applied to all resources.

Naming: * VPC: project-bedrock-vpc

Cluster: project-bedrock-cluster

Namespace: retail-app

Lambda: bedrock-asset-processor

🚀 Engineering Challenges & Resolutions
1. Resource Bottlenecks (The "t3.micro" Issue)
Challenge: Initial deployment on t3.micro instances led to Insufficient memory and Too many pods errors. The ui service alone required 512Mi of RAM, exceeding the available allocatable memory on micro instances. Resolution: Upgraded the Managed Node Group to t3.medium. This provided 4GB of RAM and a higher ENI limit, allowing all 10 microservices (including MySQL, PostgreSQL, and Redis) to reach a Running state.

2. Terraform Provider Conflict (Error 409)
Challenge: A timeout during the creation of the amazon-cloudwatch-observability EKS Add-on resulted in the resource existing in AWS but not in the Terraform state file. Resolution: Performed a terraform import to reconcile the state. This allowed the IaC pipeline to resume without attempting to recreate existing resources.

3. Service Dependency Race Condition
Challenge: The catalog pod frequently entered a CrashLoopBackOff because it attempted to connect to the catalog-mysql database before the database was ready. Resolution: Implemented a kubectl rollout restart strategy to allow the catalog service to reconnect once the database reached a healthy state.

📊 Deployment Commands
To reproduce this infrastructure:

Bash
# Initialize Terraform
terraform init

# Apply Infrastructure
terraform apply -auto-approve

# Update Kubeconfig
aws eks update-kubeconfig --region us-east-1 --name project-bedrock-cluster

# Verify Pod Status
kubectl get pods -n retail-app
👥 Developer Access (View-Only)
An IAM user has been provisioned with limited cluster visibility.

IAM User: bedrock-dev-view

Kubernetes Group: bedrock-dev-group

Policy: AmazonEKSViewPolicy

📄 License
This project is part of the AltSchool Cloud Engineering Capstone 2025.

Final steps for you, Isaac:
Save this as README.md.

Run:

Bash
git add README.md
git commit -m "Add comprehensive documentation"
git push origin main
