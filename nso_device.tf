locals {
  nso_devices = flatten([
    for device in local.devices : [
      for nso_device in try(local.device_config[device.name].devices, []) : {
        key            = format("%s/%s", device.name, nso_device.name)
        nso_instance   = device.name
        name           = nso_device.name
        address        = try(nso_device.address, local.defaults.nso.devices.configuration.devices.address, null)
        admin_state    = try(nso_device.admin_state, local.defaults.nso.devices.configuration.devices.admin_state, null)
        authgroup      = try(nso_device.authgroup, local.defaults.nso.devices.configuration.devices.authgroup, null)
        cli_ned_id     = try(nso_device.cli_ned_id, local.defaults.nso.devices.configuration.devices.cli_ned_id, null)
        generic_ned_id = try(nso_device.generic_ned_id, local.defaults.nso.devices.configuration.devices.generic_ned_id, null)
        netconf_net_id = try(nso_device.netconf_net_id, local.defaults.nso.devices.configuration.devices.netconf_net_id, null)
        port           = try(nso_device.port, local.defaults.nso.devices.configuration.devices.port, null)
      }
    ]
  ])
}

resource "nso_device" "device" {
  for_each       = { for d in local.nso_devices : d.key => d }
  instance       = each.value.nso_instance
  name           = each.value.name
  address        = each.value.address
  admin_state    = each.value.admin_state
  authgroup      = each.value.authgroup
  cli_ned_id     = each.value.cli_ned_id
  generic_ned_id = each.value.generic_ned_id
  netconf_net_id = each.value.netconf_net_id
  port           = each.value.port
}
