data "vsphere_host" "host" {
  name          = var.host
  datacenter_id = var.config.datacenter
}
resource "vsphere_folder" "folder" {
  path                = "${local.path_prefix}/${var.name}" #/DAI-labore/vm/CCs/SEC     
  type                = local.folder_type
  datacenter_id       = var.config.datacenter
}
module "network" {
  source              = "./modules/network"
  attack_flag         = (var.creat_attack_network ? 1 : 0 )
  control_flag        = (var.creat_control_network ? 1 : 0 )
  config              = var.config
  name                = var.name
  host                = local.host                  
}
module "vms" {
  //depends_on = [module.network]
  source              = "./modules/vm"
  count               = length(var.maschinen)
  config              = var.config
  name                = count.index
  host                = local.host 
  template            = var.maschinen[count.index].template         
  folder              = local.folder
  username            = var.maschinen[count.index].username
  //network flages
  out_attack          = (var.maschinen[count.index].out_attack ? var.config.out_attack: null )
  out_control         = (var.maschinen[count.index].out_control ? var.config.out_control: null )
  attack_network      = (var.maschinen[count.index].attack_network ? local.attack_network: null)
  control_network     = (var.maschinen[count.index].control_network ? local.control_network: null) 
  network_waiter      = (var.maschinen[count.index].network_waiter ?   local.network_waiter_attacker: local.network_waiter_default)    #local.network_waiter_default
  use_static_mac      = (count.index < 10 ? var.maschinen[count.index].use_static_mac: false) //TODO better procedures for static mac address writing 
  }

#########################################################
