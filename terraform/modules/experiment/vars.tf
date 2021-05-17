
variable "config"   {}
variable "experiment" {}



locals{
    path_prefix                 = "CCs/SEC"
    folder                      = vsphere_folder.folder.path 
    network_waiter_attacker     = 5
    network_waiter_default      = 0

    attack_network              = (var.experiment.creat_attack_network) ? module.network.attack_network[0]:null
    control_network              = (var.experiment.creat_control_network) ? module.network.control_network[0]:null
    host                        = data.vsphere_host.host.id

    
}