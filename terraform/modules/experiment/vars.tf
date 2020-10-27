variable "host"     {}
variable "config"   {}
variable "name"     {}
variable "templates"{}
variable "network_public"{}

locals{
    path_prefix                 = "CCs/SEC"
    folder                      = vsphere_folder.folder.path 
    network_waiter_attacker     = 5
    network_waiter_default      = 0
    inside_network              = module.network.inside_network 
    public_network              = module.network.public_network
}