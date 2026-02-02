module "model" {
  source = "./modules/model"

  yaml_directories          = var.yaml_directories
  yaml_files                = var.yaml_files
  model                     = var.model
  managed_device_groups     = var.managed_device_groups
  managed_devices           = var.managed_devices
  write_model_file          = var.write_model_file
  write_default_values_file = var.write_default_values_file
}

locals {
  model    = module.model.model
  defaults = module.model.default_values
  nso      = try(local.model.nso, {})
  devices  = try(local.nso.devices, [])

  device_config = { for device in try(local.nso.devices, []) :
    device.name => try(device.configuration, {})
  }

  provider_devices = module.model.devices
}

provider "nso" {
  username  = try(local.nso.global.username, null)
  password  = try(local.nso.global.password, null)
  insecure  = try(local.nso.global.insecure, null)
  retries   = try(local.nso.global.retries, null)
  instances = local.provider_devices
}

# locals {
#   cli_templates_0 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 0
#     ]
#   ])
#   cli_templates_1 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 1
#     ]
#   ])
#   cli_templates_2 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 2
#     ]
#   ])
#   cli_templates_3 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 3
#     ]
#   ])
#   cli_templates_4 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 4
#     ]
#   ])
#   cli_templates_5 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 5
#     ]
#   ])
#   cli_templates_6 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 6
#     ]
#   ])
#   cli_templates_7 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 7
#     ]
#   ])
#   cli_templates_8 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 8
#     ]
#   ])
#   cli_templates_9 = flatten([
#     for device in local.devices : [
#       for template in try(device.cli_templates, []) : {
#         key     = format("%s/%s", device.name, template.name)
#         device  = device.name
#         content = join(" ", [for line in split("\n", template.content) : trimspace(line) if trimspace(line) != ""])
#       } if try(template.order, local.defaults.nso.templates.order) == 9
#     ]
#   ])
# }

# resource "nso_cli" "cli_0" {
#   for_each = { for e in local.cli_templates_0 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   # depends_on = [
#   #   # future
#   # ]
# }

# resource "nso_cli" "cli_1" {
#   for_each = { for e in local.cli_templates_1 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_0
#   ]
# }

# resource "nso_cli" "cli_2" {
#   for_each = { for e in local.cli_templates_2 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_1
#   ]
# }

# resource "nso_cli" "cli_3" {
#   for_each = { for e in local.cli_templates_3 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_2
#   ]
# }

# resource "nso_cli" "cli_4" {
#   for_each = { for e in local.cli_templates_4 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_3
#   ]
# }

# resource "nso_cli" "cli_5" {
#   for_each = { for e in local.cli_templates_5 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_4
#   ]
# }

# resource "nso_cli" "cli_6" {
#   for_each = { for e in local.cli_templates_6 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_5
#   ]
# }

# resource "nso_cli" "cli_7" {
#   for_each = { for e in local.cli_templates_7 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_6
#   ]
# }

# resource "nso_cli" "cli_8" {
#   for_each = { for e in local.cli_templates_8 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_7
#   ]
# }

# resource "nso_cli" "cli_9" {
#   for_each = { for e in local.cli_templates_9 : e.key => e }
#   device   = each.value.device
#   cli      = each.value.content

#   depends_on = [
#     nso_cli.cli_8
#   ]
# }
