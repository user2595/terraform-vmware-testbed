##########################################################################
############ DAI-bezifisch ###############################################
##########################################################################
variable "vsphere_network_public"               {default="SEC_Testbed_Uplink"}
##########################################################################
############ VM-bezifisch ################################################
##########################################################################
variable "vsphere_virtual_machine_name"         {default= "terraform-test"}
variable "vsphere_virtual_machine_num_cpus"     {default= 4 }
variable "vsphere_virtual_machine_memory"       {default= 16384}
variable "vsphere_virtual_machine_gust_id"      {default= "other3xLinux64Guest"}
variable "vsphere_virtual_machine_disk_label"   {default= "disk0"}
variable "vsphere_virtual_machine_disk_size"    {default= 30}
##########################################################################
############ Templet ###############################################
##########################################################################
variable "vsphere_template_kalivm"              {default= "kaliVM"}
variable "vsphere_template"                     {default= "MinUv2"} 
