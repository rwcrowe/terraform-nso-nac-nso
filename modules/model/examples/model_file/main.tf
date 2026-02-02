module "model" {
  source  = "netascode/nac-nso/nso//modules/model"
  version = ">= 0.1.0"

  yaml_directories = ["data/"]
  write_model_file = "model.yaml"
}
