##########################################################################
############ VM-bezifisch ###############################################
##########################################################################
vsphere_virtual_machine_name                = "terraform-test"
vsphere_virtual_machine_num_cpus            = 4
vsphere_virtual_machine_memory              = 16384
vsphere_virtual_machine_gust_id             = "other3xLinux64Guest"
vsphere_virtual_machine_disk_label          = "disk0"
vsphere_virtual_machine_disk_size           = 30
##########################################################################
############ Templets ###############################################
##########################################################################
vsphere_template_DHCP                       = "sec-dhcp"
vsphere_template_kalivm                     = "kaliVM"
vsphere_template                            = "MinUv2"
##########################################################################
############ other stuff ###############################################
##########################################################################
vsphere_network_public                      = "SEC_Testbed_Uplink"
vsphere_host_name                           = "vsphere7.dai-lab.de"
