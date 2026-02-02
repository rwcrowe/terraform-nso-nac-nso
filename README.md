<!-- BEGIN_TF_DOCS -->
# Terraform Network-as-Code Cisco NSO Module

A Terraform module to configure Cisco NSO devices.

## Usage

This module supports an inventory driven approach, where a complete NSO configuration or parts of it are either modeled in one or more YAML files or natively using Terraform variables.

## Examples

Configuring an NSO device-group configuration using YAML:

#### `system.nac.yaml`

```yaml
nso:
  url: https://10.122.20.77:2639
  configuration:
    device_groups:
      - name: group1
        device_name:
          - xrv9k-01
        ned_id: "cisco-iosxr-cli-7.6.6:cisco-iosxr-cli-7.6.6"
```

#### `main.tf`

```hcl
module "nso" {
  source  = "netascode/nac-nso/nso"
  version = ">= 0.2.1"

  yaml_files = ["system.nac.yaml"]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_nso"></a> [nso](#requirement\_nso) | >= 0.2.1 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | 1.1.0-beta3 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_managed_device_groups"></a> [managed\_device\_groups](#input\_managed\_device\_groups) | List of device group names to be managed. By default all device groups will be managed. | `list(string)` | `[]` | no |
| <a name="input_managed_devices"></a> [managed\_devices](#input\_managed\_devices) | List of device names to be managed. By default all devices will be managed. | `list(string)` | `[]` | no |
| <a name="input_model"></a> [model](#input\_model) | As an alternative to YAML files, a native Terraform data structure can be provided as well. | `map(any)` | `{}` | no |
| <a name="input_write_default_values_file"></a> [write\_default\_values\_file](#input\_write\_default\_values\_file) | Write all default values to a YAML file. Value is a path pointing to the file to be created. | `string` | `""` | no |
| <a name="input_write_model_file"></a> [write\_model\_file](#input\_write\_model\_file) | Write the full model including all resolved templates to a single YAML file. Value is a path pointing to the file to be created. | `string` | `""` | no |
| <a name="input_yaml_directories"></a> [yaml\_directories](#input\_yaml\_directories) | List of paths to YAML directories. | `list(string)` | `[]` | no |
| <a name="input_yaml_files"></a> [yaml\_files](#input\_yaml\_files) | List of paths to YAML files. | `list(string)` | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_values"></a> [default\_values](#output\_default\_values) | All default values. |
| <a name="output_model"></a> [model](#output\_model) | Full model. |
## Resources

| Name | Type |
|------|------|
| [nso_device.device](https://registry.terraform.io/providers/CiscoDevNet/nso/latest/docs/resources/device) | resource |
| [nso_device_group.device_group](https://registry.terraform.io/providers/CiscoDevNet/nso/latest/docs/resources/device_group) | resource |
| [nso_global_settings.global_settings](https://registry.terraform.io/providers/CiscoDevNet/nso/latest/docs/resources/global_settings) | resource |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_model"></a> [model](#module\_model) | ./modules/model | n/a |
<!-- END_TF_DOCS -->