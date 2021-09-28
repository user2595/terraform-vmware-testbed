
output "attack_network" {
value = (var.attack_flag == 1 ?data.vsphere_network.attack_network[*].id: null )
}
output "control_network" {
value =  (var.control_flag==1  ?data.vsphere_network.control_network[*].id: null )
}

