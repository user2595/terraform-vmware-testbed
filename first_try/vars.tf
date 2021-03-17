variable "vsphere_user" {}

variable "vsphere_password"                     {}
variable "vsphere_server"                       {}
variable "vsphere_unverified_ssl"               {}
variable "vsphere_version"                      {}
variable "vsphere_datacenter"                   {}
variable "vsphere_datastore"                    {}
variable "vsphere_resource_pool"                {}
variable "vsphere_cluster"                      {}
variable "vsphere_network"                      {}
variable "vsphere_network_privat"               {}
variable "vsphere_network_public"               {}
variable "vsphere_virtual_machine_name"         {}
variable "vsphere_virtual_machine_num_cpus"     {}
variable "vsphere_virtual_machine_memory"       {}
variable "vsphere_virtual_machine_gust_id"      {}
variable "vsphere_virtual_machine_disk_label"   {}
variable "vsphere_virtual_machine_disk_size"    {}

variable "vsphere_template_DHCP"             {}
variable "vsphere_template_DHCP_host_name"   {}
variable "vsphere_templete_DHCP_domain"      {}

variable "vsphere_template_kalivm"             {}
variable "vsphere_template_kalivm_host_name"   {}
variable "vsphere_templete_kalivm_domain"      {}

variable "vsphere_template"             {}
variable "vsphere_template_host_name"   {}
variable "vsphere_templete_domain"      {}

variable "vsphere_distributed_virtual_switch_name"      {}
variable "vsphere_distributed_port_group_name"          {}
variable "vsphere_host_virtual_switch_name" {}
variable "vsphere_host_port_group_name" {}
variable "vsphere_host_name" {}