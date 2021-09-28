
variable "config"                               {}

variable "name"                                 {}
variable "host"                                 {}
variable "creat_attack_network"                 {}
variable "creat_control_network"                {}
variable "maschinen"                            {}
    

locals{
    path_prefix                 = "CCs/SEC"
    folder                      = vsphere_folder.folder.path 
    network_waiter_attacker     = 5
    network_waiter_default      = 0

    attack_network              = (var.creat_attack_network) ? module.network.attack_network[0]:null
    control_network             = (var.creat_control_network) ? module.network.control_network[0]:null
    host                        = data.vsphere_host.host.id
    folder_type                 = "vm"
    
}