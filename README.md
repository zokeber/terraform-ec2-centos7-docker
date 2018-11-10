# Terraform : AWS EC2 + VPC + Docker CE in CentOS 7

My terraform script for provisioning a AWS EC2 instance with Docker CE running in CentOS 7

## Usage
```bash
terraform init
terraform plan -out tfplan -input=false
terraform apply -input=false tfplan
```
### Requirements

- [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)

**Important:**

AWS Credentials with all permission for create EC2 instances, Security Groups, EBS, VPC, Subnet, Internet Gateway and Nat Gateway.

### More options

#### Enable AWS Elastic IP Address:

By default AWS Elastic IP Address assign is disable, if you want enable a AWS Elasitc IP, run:

```bash
terraform plan -out tfplan -input=false -var 'elastic_ip=true'
terraform apply -input=false tfplan
```
#### Enable Nat Gateway:

By default AWS Nat Gateway is disable, if you want enable a AWS Nat Gateway, please run:

```bash
terraform plan -out tfplan -input=false -var 'enable_nat_gateway=true'
terraform apply -input=false tfplan
```

### Destroy
```bash
terraform plan -destroy -out destroy.plan
terraform apply "destroy.plan"
```

### What does this do?

This is a terraform files and designed to create a AWS EC2 instance with Docker CE running in CentOS 7 x86_64.

## Contributing

We welcome contributions! If you have an idea or contribution that might improve this repository, see [CONTRIBUTING](https://github.com/zokeber/terraform-ec2-centos7-docker/blob/master/CONTRIBUTING.md) for more information on how to get started. Questions are also welcome (as issues). We gladly credit all contributors.
