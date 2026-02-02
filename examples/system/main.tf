module "nso" {
  source  = "netascode/nac-nso/nso"
  version = ">= 0.2.1"

  yaml_files = ["system.nac.yaml"]
}
