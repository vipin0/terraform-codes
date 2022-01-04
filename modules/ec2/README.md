## This module creates EC2 instance alongwith security group with given values.
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.app_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.instance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI id for the instance. | `string` | n/a | yes |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Assign public IP address to instances | `bool` | `true` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instance to launch. | `number` | `1` | no |
| <a name="input_instance_ingress_ports"></a> [instance\_ingress\_ports](#input\_instance\_ingress\_ports) | ingress ports | `list(string)` | `[]` | no |
| <a name="input_instance_ssh_cidrs"></a> [instance\_ssh\_cidrs](#input\_instance\_ssh\_cidrs) | IP to allow ssh connection to instances | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Intance type to run | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | key for the instance to SSH | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | Path of private key | `string` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of security group for EC2 istance. | `string` | `"instance-security-group-tf"` | no |
| <a name="input_subnets_ids"></a> [subnets\_ids](#input\_subnets\_ids) | subnet ids in which instances are to be launched. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag for the resources. | `map(any)` | <pre>{<br>  "ManagedBy": "Terraform"<br>}</pre> | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | user-data for ec2. | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id of security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_count"></a> [instance\_count](#output\_instance\_count) | Number of instances launched |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | Instance ids |
| <a name="output_instance_ips"></a> [instance\_ips](#output\_instance\_ips) | Instances public ips |
<!-- END_TF_DOCS -->