# tf-cloud-master

This repo is part of series of personal repos where I do tests on the following topics:

1. Terraform Cloud CI/CD pipeline based on GitHub Actions for central infrastructure and release management and team collaboration
2. Managing and Deploying EKS cluster (dev and prod stages)
3. Deploying test apps on the EKS cluster (dev and prod stages)
4. Central AWS VPC (peered with PROD and DEV VPCs), used for Client VPN connection with Certificase based authentication
5. GitHub Actions running in every repo with special rules to check the Terrafrom code before merging branches (more check can be added)

This particular repo is for setting up the AWS Organizations, IAM roles, IAM users and groups etc. It is not real AWS organizations as it is using only one AWS account.
In a real AWS organizations you would have:
    - Many AWS accounts organized in tree structure and Service Control Policies placed.
    - Central place for API logs
    - User Access in the subaccount is based on IAM roles with trust in the main/master AWS account