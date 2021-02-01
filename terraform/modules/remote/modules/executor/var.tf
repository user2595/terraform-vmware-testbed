##########################################################################
############ connection ##################################################
##########################################################################
variable "connection_host" {}
variable "connection_user" {}
variable "connection_type" {default = "ssh"}
##########################################################################
############ file ########################################################
##########################################################################
# variable "file_source"      { default= "/home/tarik/DAI/hello-world.txt"}
# variable "file_destination" { default= "/tmp/hello-world.txt"}
##########################################################################
############ remote-exec ##################################################
##########################################################################
variable "remote_exec_command" {default = ["sudo apt install python -y"] }
##########################################################################
############ local-exec ##################################################
##########################################################################
variable "path_to_playbook"     {default = "../ansible/dummyPlaybook.yml"   }



data "ansiblevault_path" "password" {
  path  = "passwords.yml"
  key   =  var.connection_user
}
locals{
 // --extra-vars='ansible_become_password=Sonne21! ansible_user_name=tarik ansible_user_ip=localhost'
  # ansible_user                   = "ansible_user='${var.connection_user}'" //ansible_user_name
  # ansible_ssh_pass               = "ansible_ssh_pass='${local.password}'"
  # ansible_sudo_pass              = "ansible_sudo_pass='${local.password}'"//ansible_become_password
  # ansible_user_ip                = "ansible_user_ip= '${var.connection_host}'"
  ansible_user_ip                = "ansible_user_ip= '${var.connection_host}'"
  ansible_user_name              = "ansible_user_name='${var.connection_user}'" //ansible_user_name
  ansible_sudo_pass              = "ansible_become_password='${local.password}'"//ansible_become_password
 
  password                       =  data.ansiblevault_path.password.value
   command = "ansible-playbook -i '${var.connection_host},' -e ${local.ansible_user_ip} -e ${local.ansible_user_name} -e ${local.ansible_sudo_pass} ${var.path_to_playbook}"
 # command = "ansible-playbook -i '${var.connection_host},' -e ${local.ansible_user} -e ${local.ansible_ssh_pass} -e ${local.ansible_sudo_pass} ${var.path_to_playbook}"
}