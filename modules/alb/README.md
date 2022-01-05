## This module create load balancer using the given values.
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
| [aws_alb_listener.alb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener_rule.alb_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_lb.my_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_target_group.my_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of Application load balancer. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | env prefix for name tag | `string` | `""` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | ALB SG name. | `string` | `"alb-security-group"` | no |
| <a name="input_subnets_ids"></a> [subnets\_ids](#input\_subnets\_ids) | IDs of subnets for ALB. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag for the resources. | `map(any)` | <pre>{<br>  "ManagedBy": "Terraform"<br>}</pre> | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | target group name. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id for TG. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_security_group_id"></a> [alb\_security\_group\_id](#output\_alb\_security\_group\_id) | ALB security group id |
| <a name="output_aws_lb_target_group_arn"></a> [aws\_lb\_target\_group\_arn](#output\_aws\_lb\_target\_group\_arn) | Target group ARN |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | Application load balancer dns name. |
<!-- END_TF_DOCS -->