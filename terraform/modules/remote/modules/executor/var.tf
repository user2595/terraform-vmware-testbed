##########################################################################
############ connection ##################################################
##########################################################################
variable "connection_host" {}
variable "connection_user" {}
variable "connection_type" {default = "ssh"}
##########################################################################
############ remote-exec ##################################################
##########################################################################
variable "remote_exec_command" {default = [ "sudo apt install python3 python3-pip -y", 
                                            "pip3 install ansible lxml"] }
##################################################################### #####
############ local-exec ##################################################
##########################################################################
variable "path_to_playbook"     {default = "dummyPlaybook.yml"   }



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
   working_dir                   = "../ansible/"
   command = "ansible-playbook  ${var.path_to_playbook}  --extra-vars=' ${local.ansible_user_ip}  ${local.ansible_user_name}  ${local.ansible_sudo_pass}' "
 # command = "ansible-playbook -i '${var.connection_host},' -e ${local.ansible_user} -e ${local.ansible_ssh_pass} -e ${local.ansible_sudo_pass} ${var.path_to_playbook}"
}