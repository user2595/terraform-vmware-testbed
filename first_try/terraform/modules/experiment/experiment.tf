resource "vsphere_folder" "folder" {
  path                = "${local.path_prefix}/${var.name}" #/DAI-labore/vm/CCs/SEC     /Testbed
  type                = "vm"
  datacenter_id       = var.config.datacenter
}
module "network" {
  source              = "./modules/network"
  config              = var.config
  name                = var.name
  host                = var.host
  network_public      = var.network_public
  
}
module "dhcp_server" {
  source = "./modules/targets"
    config              = var.config
    name                = var.name
    host                = var.host
    template            = list(var.templates[0]) //needs a list as input 
    folder              = local.folder
    inside_network      = local.inside_network 
    network_waiter      = local.network_waiter_default
    }
module "attacker" {
  source                = "./modules/targets"
  config                = var.config
  name                  = var.name
  host                  = var.host
  template              = list(var.templates[1]) //needs a list as input 
  folder                = local.folder
   inside_network       = local.inside_network      
   public_network       = local.public_network.id // public_network nedd a string es input 
   network_waiter       = local.network_waiter_attacker
}
module "targets" {
  source                = "./modules/targets"
  config                = var.config
  name                  = var.name
  host                  = var.host
  template              = slice(var.templates,2,length(var.templates)) //templates[2::] the tail of the tamplates
  folder                = local.folder
  network_waiter        = local.network_waiter_default
  inside_network        = local.inside_network 
}