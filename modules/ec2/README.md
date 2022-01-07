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
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.as_conf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_launch_template.launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.instance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_security_group_id"></a> [alb\_security\_group\_id](#input\_alb\_security\_group\_id) | ALB security group id | `string` | n/a | yes |
| <a name="input_alb_target_group_arn"></a> [alb\_target\_group\_arn](#input\_alb\_target\_group\_arn) | alb target group arn | `string` | n/a | yes |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI id for the instance. | `string` | n/a | yes |
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | ASG name | `string` | `"demoASG"` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Assign public IP address to instances | `bool` | `false` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | ASG desired\_capacity | `number` | n/a | yes |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | asg health check type | `string` | `"ELB"` | no |
| <a name="input_instance_ingress_ports"></a> [instance\_ingress\_ports](#input\_instance\_ingress\_ports) | ingress ports | `list(string)` | `[]` | no |
| <a name="input_instance_ssh_cidrs"></a> [instance\_ssh\_cidrs](#input\_instance\_ssh\_cidrs) | IP to allow ssh connection to instances | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Intance type to run | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | key for the instance to SSH | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | ASG max size | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | ASG max size | `number` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of security group for EC2 istance. | `string` | `"instance-security-group"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | subnet ids in which instances are to be launched. | `list(string)` | n/a | yes |
| <a name="input_tag_prefix"></a> [tag\_prefix](#input\_tag\_prefix) | env tag\_prefix for name tag | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag for the resources. | `map(any)` | <pre>{<br>  "ManagedBy": "Terraform"<br>}</pre> | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | user-data for ec2. | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id of security group | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->