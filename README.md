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
| [aws_ami.latest_amazon_linux_ami](https://registry.terraform.io/providers/hashicorp/aws/3.68.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additonal_tags"></a> [additonal\_tags](#input\_additonal\_tags) | Addtional Tags for resources. | `map(any)` | <pre>{<br>  "ManagedBy": "Terraform"<br>}</pre> | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | associate public ip address to the instances | `string` | n/a | yes |
| <a name="input_azs"></a> [azs](#input\_azs) | List of availability zones. | `list(string)` | n/a | yes |
| <a name="input_credential_profile"></a> [credential\_profile](#input\_credential\_profile) | Credential profile for AWS | `string` | `"default"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | db instance class | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username | `string` | n/a | yes |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired number of instanes for ASG | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | database identidier | `string` | n/a | yes |
| <a name="input_instance_ingress_ports"></a> [instance\_ingress\_ports](#input\_instance\_ingress\_ports) | instance ingress ports | `list(string)` | n/a | yes |
| <a name="input_instance_ssh_cidrs"></a> [instance\_ssh\_cidrs](#input\_instance\_ssh\_cidrs) | instance ssh cidrs | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance Type to launch | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | key for the instance to SSH | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Max number of instanes for ASG | `string` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Min number of instanes for ASG | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ALB name | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | cidr blocks of private subnets. | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | cidr blocks of public subnets. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-2"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | db instance class | `string` | n/a | yes |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | rds subnet group name | `string` | n/a | yes |
| <a name="input_tag_prefix"></a> [tag\_prefix](#input\_tag\_prefix) | Prefix for name tag of the resources. | `string` | `""` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | target group name | `string` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data for instance | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr block | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Dns name of the load balancer. |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | RDS endpoint address. |
<!-- END_TF_DOCS -->