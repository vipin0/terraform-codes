## This module create a RDS instance alongwith subnet group and security group with given values.
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
| [aws_db_instance.my_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.db_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Stoage for RDS. | `number` | `10` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | Allowed cidr block through RDS SG. | `list(string)` | n/a | yes |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | Instance type / size for RDS. | `string` | `"db.t3.micro"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username | `string` | n/a | yes |
| <a name="input_engine"></a> [engine](#input\_engine) | Database Engine. | `string` | `"mysql"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Database Engine Version. | `string` | `"5.7"` | no |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | from\_port for DB. | `number` | `3306` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifier for RDS. | `string` | `"my-demo-rds"` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Database parameter group name. | `string` | `"default.mysql5.7"` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | protocol | `string` | `"tcp"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Security group name for RDS. | `string` | `"rds-security-group"` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Name of RDS subnet group. | `string` | `"demo-subnet-group"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet ids for RDS subnet group. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag for the resources. | `map(any)` | <pre>{<br>  "ManagedBy": "Terraform"<br>}</pre> | no |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | to\_port for DB. | `number` | `3306` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VCP id for Security group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | database address |
| <a name="output_rds_port"></a> [rds\_port](#output\_rds\_port) | database port |
<!-- END_TF_DOCS -->