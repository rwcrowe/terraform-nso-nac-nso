terraform {
  required_version = ">= 1.8.0"

  required_providers {
    nso = {
      source  = "CiscoDevNet/nso"
      version = ">= 0.2.1"
    }
    utils = {
      source  = "netascode/utils"
      version = "1.1.0-beta3"
    }
  }
}
