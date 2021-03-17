# Finally, we're outputting the IP address of the new attacker vm
output "name" {
  value ="${vsphere_virtual_machine.vm.name}"  //split("_", vsphere_virtual_machine.vm.name)[1] 
  description = "The name of this instance."
}
output "ip_address" {
  value = "${vsphere_virtual_machine.vm.default_ip_address}" 
  description = "The ip of this instance."
}
output "username" {
  value = var.username
}