module "attacker" {
    source              = "./modules/executor"
    connection_host     = local.attack_ip[0]
    connection_user     = local.attack_username[0]
    connection_type     = "ssh"
    file_source         = "/home/tarik/DAI/hello-world.txt"
    file_destination    = "/tmp/hello-world.txt"
    remote_exec_command = "sudo apt install python -y"
    path_to_playbook    = "../ansible/dummyPlaybook.yml"
}

