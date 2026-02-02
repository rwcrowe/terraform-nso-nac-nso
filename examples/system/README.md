<!-- BEGIN_TF_DOCS -->
# IOS-XR Hostname Configuration Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

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
<!-- END_TF_DOCS -->