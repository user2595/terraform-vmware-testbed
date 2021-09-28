# Finally, we're outputting the IP address of the new VM
output "ip_list" {
depends_on=[module.vms]
 value ={
   for vm in module.vms:
      "${vm.name}" => vm.ip_address
      if vm.username != null
   }
}
output "username_list" {
depends_on=[module.vms]
 value ={
   for vm in module.vms:
     "${vm.name}" => vm.username
     if vm.ip_address != null
   }
}