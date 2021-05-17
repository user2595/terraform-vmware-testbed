terraform {
  required_providers {
    ansiblevault = {
      source = "MeilleursAgents/ansiblevault"
      version = "2.2.0"
    }
  }
}
//need for ssh password sshpass - sudo apt install sshpass
resource "null_resource" "remote-executor" {
//always run remote-exec whenn terraform apply 
 //triggers = {
   // always_run = "${timestamp()}"
  //}

connection {
      type     = var.connection_type
      user     = var.connection_user
      #private_key = file(var.provisioning_key_path)
      #agent = true
      password = local.password
      host     = var.connection_host
      timeout = "10m"
    }



  provisioner "remote-exec" {
    inline = concat( ["echo ${local.password}  | sudo -S  apt-get update ; "],var.remote_exec_command )
  }


}

//need for ssh password sshpass - sudo apt install sshpass
resource "null_resource" "local-executor" {
//always run local-exec whenn terraform apply
 depends_on = [null_resource.remote-executor]
 triggers = {
    always_run = "${timestamp()}"
  }


  provisioner "local-exec" {
  working_dir = local.working_dir
  command   =     local.command
  }
}