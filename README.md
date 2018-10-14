# Terraform : AWS EC2 + VPC + Docker CE in CentOS 7

My terraform script for provisioning a AWS EC2 instance with Docker CE running in CentOS 7

## Usage
```
terraform init
terraform plan -out tfplan -input=false
terraform apply -input=false tfplan
```
### Requirements

- [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)

**Important:**

AWS Credentials with all permission for create EC2 instances, Security Groups, EBS, VPC, Subnet, Internet Gateway and Nat Gateway.

### What does this do?

This is a terraform files and designed to create a AWS EC2 instance with Docker CE running in CentOS 7 x86_64.

## Contributing

We welcome contributions! If you have an idea or contribution that might improve this repository, see CONTRIBUTING for more information on how to get started. Questions are also welcome (as issues). We gladly credit all contributors.