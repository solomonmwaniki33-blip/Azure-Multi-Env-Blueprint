module "prod_infra" {
  source = "../../modules/networking_app"

  #environment specific variables
  env = var.env
  project_name = "multiterraform"
  location = "southafricanorth"
  vnet_cidr = var.vnet_cidr
  vm_size = var.vm_size
  admin_user = "prodadmin"

}

