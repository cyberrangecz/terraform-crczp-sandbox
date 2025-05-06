# terraform-crczp-sandbox
Terraform module which creates sandbox definition, sandbox pool and allocation units in CRCZP. Additionally it saves outputs of allocation units stages to local files.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_crczp"></a> [crczp](#requirement\_crczp) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_crczp"></a> [crczp](#provider\_crczp) | >= 0.2.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [crczp_sandbox_allocation_unit.sandbox](https://registry.terraform.io/providers/cyberrangecz/crczp/latest/docs/resources/sandbox_allocation_unit) | resource |
| [crczp_sandbox_definition.definition](https://registry.terraform.io/providers/cyberrangecz/crczp/latest/docs/resources/sandbox_definition) | resource |
| [crczp_sandbox_pool.pool](https://registry.terraform.io/providers/cyberrangecz/crczp/latest/docs/resources/sandbox_pool) | resource |
| [local_sensitive_file.output](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [null_resource.check](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [crczp_sandbox_request_output.output](https://registry.terraform.io/providers/cyberrangecz/crczp/latest/docs/data-sources/sandbox_request_output) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_output_directory"></a> [output\_directory](#input\_output\_directory) | The directory where files with outputs will be created. | `string` | `"outputs"` | no |
| <a name="input_pool_size"></a> [pool\_size](#input\_pool\_size) | The maximum number of sandboxes that can be allocated in a pool. Defaults to sandbox\_count. | `number` | `null` | no |
| <a name="input_project_url"></a> [project\_url](#input\_project\_url) | Url to Git repository with sandbox definition, as obtained by Clone with SSH or HTTPS. | `string` | n/a | yes |
| <a name="input_refresh_image_cache"></a> [refresh\_image\_cache](#input\_refresh\_image\_cache) | n/a | `bool` | `false` | no |
| <a name="input_rev"></a> [rev](#input\_rev) | Git revision of the Git repository from project\_url to use. | `string` | n/a | yes |
| <a name="input_sandbox_count"></a> [sandbox\_count](#input\_sandbox\_count) | The number of sandboxes to be allocated. | `number` | `1` | no |
| <a name="input_stages"></a> [stages](#input\_stages) | Set of stages whose output from sandbox allocation will be saved to files in output\_directory. One file per each combination of stage and sandbox. | `set(string)` | <pre>[<br/>  "user-ansible",<br/>  "networking-ansible",<br/>  "terraform"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition_id"></a> [definition\_id](#output\_definition\_id) | Id of created sandbox definition. |
| <a name="output_pool_id"></a> [pool\_id](#output\_pool\_id) | Id of created sandbox pool. |
| <a name="output_sandbox_ids"></a> [sandbox\_ids](#output\_sandbox\_ids) | List of ids of created sandboxes. |
<!-- END_TF_DOCS -->

**Author**: Zdeněk Vydra
