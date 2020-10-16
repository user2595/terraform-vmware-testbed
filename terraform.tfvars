
#########################################################################
######### Provider#######################################################
#########################################################################
#vsphere_user                        = ""
#vsphere_password                    = ""



vsphere_server                      = "vcenter.dai-lab.de"
# If you have a self-signed cert
vsphere_unverified_ssl              = true 
vsphere_version                     = "1.12.0"
##########################################################################
############ DAI-bezifisch ###############################################
##########################################################################
vsphere_datacenter                  = "DAI-Labor"
vsphere_datastore                   = "VM-Storage3"
vsphere_resource_pool               = "Testbed"
vsphere_cluster                     = "UCS"
vsphere_network                     = ""
vsphere_network_privat              = "TestBedNet_Port"
vsphere_network_public              = "SEC_Testbed_Uplink"
##########################################################################
############ VM-bezifisch ###############################################
##########################################################################
vsphere_virtual_machine_name        = "terraform-test"
vsphere_virtual_machine_num_cpus    = 4
vsphere_virtual_machine_memory      = 16384
vsphere_virtual_machine_gust_id     = "other3xLinux64Guest"

vsphere_virtual_machine_disk_label  = "disk0"
vsphere_virtual_machine_disk_size   = 30
##########################################################################
############ Templet ###############################################
##########################################################################
vsphere_template_DHCP                    = "sec-dhcp"
vsphere_template_DHCP_host_name          = "sec-dhcp"
vsphere_templete_DHCP_domain             = "testbed.de"

vsphere_template_kalivm                    = "kaliVM"
vsphere_template_kalivm_host_name          = "kalivm"
vsphere_templete_kalivm_domain             = "testbed.de"


vsphere_template                        = "MinUv2"
vsphere_template_host_name              = "minuv2"
vsphere_templete_domain                 = "testbed.de"




vsphere_host_name = "vsphere7.dai-lab.de"
vsphere_host_virtual_switch_name = "vSwitchTerraformTest"
vsphere_host_port_group_name = "PGTerraformTest"



vsphere_distributed_virtual_switch_name = "test_testBedNet"
vsphere_distributed_port_group_name     = "test_testBedNet_port_group"
