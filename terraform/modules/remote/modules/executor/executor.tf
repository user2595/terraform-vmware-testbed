
//need for ssh password sshpass - sudo apt install sshpass
resource "null_resource" "executor" {
connection {
      type     = "ssh"
      user     = "kalivm"
      #private_key = file(var.provisioning_key_path)
      #agent = true
      password = "=0OOA4A5f6P"
      host     = var.host
    }

    provisioner "file" {
    source = "/home/tarik/DAI/hello-world.txt"
    destination = "/tmp/hello-world.txt"
  }

  provisioner "remote-exec" {
    inline = [ "echo =0OOA4A5f6P | sudo -S apt update",
                "sudo apt install python -y" ]
  }


  provisioner "local-exec" {
  command = "ansible-playbook -i '${var.host},' -e ansible_user='kalivm' ansible_ssh_pass='=0OOA4A5f6P' ansible_sudo_pass='=0OOA4A5f6P' ../ansible/dumyPlaybook.yml"
  }
}