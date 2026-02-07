#!/bin/bash
# Final Attempt: OCI Registry with Verified Version

echo "1. Connecting to Cluster..."
aws eks update-kubeconfig --region us-east-1 --name project-bedrock-cluster

echo "2. Ensuring Namespace exists..."
kubectl create namespace retail-app --dry-run=client -o yaml | kubectl apply -f -

echo "3. Installing Retail Store App (OCI)..."
# We use version 0.8.5 which is confirmed to exist on public.ecr.aws
helm install retail-app oci://public.ecr.aws/aws-containers/retail-store-sample-chart --version 0.8.5 -n retail-app

echo "4. Waiting for pods..."
sleep 5
kubectl get pods -n retail-app