terraform {
  required_providers {
    ansiblevault = {
      source = "MeilleursAgents/ansiblevault"
      version = "2.2.0"
    }
  }
}
//https://meilleursagents.github.io/terraform-provider-ansiblevault/
provider "ansiblevault" {
  vault_path  = var.ansible_vault_vault_path
  root_folder = var.ansible_vault_root_folder 
}
data "ansiblevault_path" "vmware_user_password" {
  path = var.ansible_vault_password_path
  key= var.vsphere_user
}
provider "vsphere" {
  user           = var.vsphere_user
  password       = data.ansiblevault_path.vmware_user_password.value
  vsphere_server = var.vsphere_server
  
  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere_unverified_ssl
  #solve ServerFaultCode: Request version 'urn:pbm/' and namespace 'urn:pbm' are not supported
}
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "out_attack" {
  name          = var.vsphere_out_attack
  datacenter_id = data.vsphere_datacenter.dc.id
}
//currently  we have only one external network 
# data "vsphere_network" "out_control" {
#   name          = var.vsphere_out_control
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

module "deployment" {
  source                        = "./modules/experiment"
  config                        = local.config
  experiment                    = local.experiment_0
  
}
module "remote_ex" {
  depends_on                    = [ module.deployment ]
  source                        = "./modules/remote"
  config                        = local.config
  deployment_out_ip_list        = module.deployment.ip_list
  deployment_out_username_list  = module.deployment.username_list
}

