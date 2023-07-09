# Deploy a Hugo container inside an Amazon Elastic Kubernetes Service Cluster using Serverless Terraform Pipeline
This repository contains code to deploy a customised Hugo container inside an Amazon Elastic Kubernetes Service cluster using a Serverless Pipeline for provisioning Terraform Projects.

# Prerequisites
Before deploying the code contained in this repository, the following must be in place.

- the Serverless Terraform Pipeline, as described in https://nivleshc.wordpress.com/2023/03/28/use-aws-codepipeline-aws-codecommit-aws-codebuild-amazon-simple-storage-service-amazon-dynamodb-and-docker-to-create-a-pipeline-to-deploy-terraform-code/

- the Amazon Elastic Kubernetes Service (Amazon EKS) cluster. which will be deployed using the above mentioned Serverless Terraform pipeline. This is described in https://nivleshc.wordpress.com/2023/06/12/create-an-amazon-elastic-kubernetes-service-cluster-using-a-serverless-terraform-pipeline/

- the Serverless Terraform Pipeline has been extended to include an Application Pipeline, as described in https://nivleshc.wordpress.com/2023/06/29/add-an-application-pipeline-to-the-serverless-terraform-pipeline/

# What will be deployed
The following resources will be deployed inside the Amazon EKS cluster.

- a kubernetes namespace will be created with a name of the format <env>-hugo
- a kubernetes deployment will be created inside the above namespace, to provision two pods using the customised hugo container image located at **nivleshc/hugo:nivleshcwordpress_0.1**
- a service will be created for the hugo pods.
- a kubernetes ingress will be created, which will expose the hugo service to the internet, via an AWS Load Balancer, on port TCP 80.

# High Level Architecture
Below is the high level architecture diagram for the entire solution. The resources in the blue rectangle (labelled "Application Pipeline") will be provisioned using the application pipeline. 

The purple arrow pointing out of the blue rectangle, into the Amazon EKS cluster (B10), depicts what the code in this repository will implement. It will deploy a customised hugo container into the Amazon EKS cluster.

![High Level Architecture DIagram](/images/Serverless%20Pipeline%20-%20Hugo%20Container%20Deployment.png "High Level Architecture Diagram")

# Implementation
Follow the deployment instructions at https://nivleshc.wordpress.com/2023/07/09/deploy-a-hugo-container-inside-an-amazon-eks-cluster-using-the-serverless-terraform-pipeline/.
