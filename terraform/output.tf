# Finally, we're outputting the IP address of the new VM
 output "out_ip_address" {
  value = module.deployment.ip_list
  description = "The Remote desktop IP address of the attackker instance."
 }
 output "out_userna" {
  value = module.deployment.username_list
  description = "The Remote desktop IP address of the attackker instance."
 }