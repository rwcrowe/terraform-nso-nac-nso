locals {
  device_groups = flatten([
    for device in local.devices : [
      for group in try(local.device_config[device.name].device_groups, []) : {
        key                = format("%s/%s", device.name, group.name)
        nso_instance       = device.name
        name               = group.name
        location_name      = try(group.location_name, local.defaults.nso.devices.configuration.device_groups.location_name, null)
        location_latitude  = try(group.location_latitude, local.defaults.nso.devices.configuration.device_groups.location_latitude, null)
        location_longitude = try(group.location_longitude, local.defaults.nso.devices.configuration.device_groups.location_longitude, null)
        location_altitude  = try(group.location_altitude, local.defaults.nso.devices.configuration.device_groups.location_altitude, null)
        device_names       = try(length(group.device_names) == 0, true) ? null : group.device_names
        device_groups      = try(length(group.device_groups) == 0, true) ? null : group.device_groups
      }
    ]
  ])
}

resource "nso_device_group" "device_group" {
  for_each           = { for dg in local.device_groups : dg.key => dg }
  instance           = each.value.nso_instance
  name               = each.value.name
  location_name      = each.value.location_name
  location_latitude  = each.value.location_latitude
  location_longitude = each.value.location_longitude
  location_altitude  = each.value.location_altitude
  device_names       = each.value.device_names
  device_groups      = each.value.device_groups

  depends_on = [
    nso_device.device
  ]
}
