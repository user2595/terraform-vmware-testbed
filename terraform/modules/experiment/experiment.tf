data "vsphere_host" "host" {
  name          = var.experiment.host
  datacenter_id = var.config.datacenter
}
resource "vsphere_folder" "folder" {
  path                = "${local.path_prefix}/${var.experiment.name}" #/DAI-labore/vm/CCs/SEC     /Testbed
  type                = "vm"
  datacenter_id       = var.config.datacenter
}
module "network" {
  source              = "./modules/network"
  attack_flag         = (var.experiment.creat_attack_network ? 1 : 0 )
  control_flag        = (var.experiment.creat_control_network ? 1 : 0 )
  config              = var.config
  name                = var.experiment.name
  host                = local.host                  
}
module "vms" {
  //depends_on = [module.network]
  source              = "./modules/vm"
  count               = length(var.experiment.maschinen)
  config              = var.config
  name                = count.index
  host                = local.host 
  template            = var.experiment.maschinen[count.index].template         
  folder              = local.folder
  username            = var.experiment.maschinen[count.index].username
  //network flages
  out_attack          = (var.experiment.maschinen[count.index].out_attack ? var.experiment.out_attack: null )
  out_control         = (var.experiment.maschinen[count.index].out_control ? var.experiment.out_control: null )
  attack_network      = (var.experiment.maschinen[count.index].attack_network ? local.attack_network: null)
  control_network     = (var.experiment.maschinen[count.index].control_network ? local.control_network: null) 
  network_waiter      = (var.experiment.maschinen[count.index].network_waiter ?   local.network_waiter_attacker: local.network_waiter_default)    #local.network_waiter_default
  use_static_mac      = (count.index < 10 ? var.experiment.maschinen[count.index].use_static_mac: false) //TODO better procedures for static mac address writing 
  }

#########################################################
