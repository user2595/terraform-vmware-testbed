# Finally, we're outputting the IP address of the new VM
 output "out_ip_address" {
  value = module.name.ip_list
  description = "The Remote desktop IP address of the attackker instance."
 }
#  output "tt" {
#      value = module.remote_ex.test
#  }