
variable "config"   {}
variable "experiment" {}



locals{
    path_prefix                 = "CCs/SEC"
    folder                      = vsphere_folder.folder.path 
    network_waiter_attacker     = 5
    network_waiter_default      = 0
    attack_network              = module.network.attack_network[0]
    control_network              = module.network.control_network[0]
    host                        = data.vsphere_host.host.id

    
}