## This is the main tf file.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.68.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/ec2 | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.ssh_key_pair](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/resources/key_pair) | resource |
| [aws_ami.latest_amazon_linux_ami](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_credential_profile"></a> [credential\_profile](#input\_credential\_profile) | Credential profile for AWS | `string` | `"default"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | `"testdb"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password | `string` | `"admin123"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username | `string` | `"admin"` | no |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | Path of private key | `string` | n/a | yes |
| <a name="input_public_key_path"></a> [public\_key\_path](#input\_public\_key\_path) | Path of public key | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-2"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr block | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Dns name of the load balancer. |
| <a name="output_private_subnets_cidrs"></a> [private\_subnets\_cidrs](#output\_private\_subnets\_cidrs) | cidr blocks of the private subnets. |
| <a name="output_public_subnets_cidrs"></a> [public\_subnets\_cidrs](#output\_public\_subnets\_cidrs) | cidr blocks of the public subnets. |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | RDS endpoint address. |
<!-- END_TF_DOCS -->