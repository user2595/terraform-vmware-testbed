terraform {
  required_providers {
    ansiblevault = {
      source = "MeilleursAgents/ansiblevault"
      version = "2.2.0"
    }
  }
}
//need for ssh password sshpass - sudo apt install sshpass
resource "null_resource" "executor" {
connection {
      type     = var.connection_type
      user     = var.connection_user
      #private_key = file(var.provisioning_key_path)
      #agent = true
      password = local.password
      host     = var.connection_host
    }

  #   provisioner "file" {
  #   source = var.file_source 
  #   destination = var.file_destination
  # }

  provisioner "remote-exec" {
    inline = concat( ["echo ${local.password} | sudo -S apt update"],var.remote_exec_command )
  }


  provisioner "local-exec" {
  command = local.command
  }
}