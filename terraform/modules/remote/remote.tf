module "attacker" {
    source = "./modules/executor"
    host = local.attack_ip[0]
    
}