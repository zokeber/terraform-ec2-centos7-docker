# Terraform : AWS EC2 + VPC + Docker CE in CentOS 7

My terraform files for provisioning an AWS EC2 instance with Docker CE running in CentOS 7

## Requirements

- [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)

**Important:**

You have to create an AWS credentials with all permission for create EC2 instance, Security Groups, Elastic IP, EBS, VPC, Subnet, Internet Gateway and NAT Gateway.

In your AWS credentials file, section profile, you have to write the same value that you set to in  ```name``` variable:

~/.aws/credentials:

```bash
[standalone-server]
aws_access_key_id =
aws_secret_access_key =

```
variables.tf:

```bash
variable "name" {
  default = "standalone-server"
}
```

## Usage
```bash
terraform init
terraform plan -out tfplan -input=false
terraform apply -input=false tfplan
```

### More usage options

#### Enable AWS Elastic IP Address:

By default AWS Elastic IP Address assign is disable, if you want to enable an Elasitc IP, run:

```bash
terraform plan -out tfplan -input=false -var 'elastic_ip=true'
terraform apply -input=false tfplan
```
#### Enable Nat Gateway:

By default AWS NAT Gateway is disable, if you want to enable a NAT Gateway, please run:

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

This is a terraform files that have been created for deployment of EC2 instance with Docker CE running in CentOS 7 x86_64.

## Contributing

We welcome contributions! If you have an idea or contribution that might improve this repository, see [CONTRIBUTING](https://github.com/zokeber/terraform-ec2-centos7-docker/blob/master/CONTRIBUTING.md) for more information on how to get started. Questions are also welcome (as issues). We gladly credit all contributors.
