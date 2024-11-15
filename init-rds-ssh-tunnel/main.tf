resource "random_password" "passwords" {
  for_each = toset(["db1_rw_user", "db1_ro_user", "db2_rw_user"])
  length = 16
  special = true
  override_special = "_!#"
}

locals {
   users = {
    db1_rw_username = "db1_rw_user"
    db1_rw_password = random_password.passwords["db1_rw_user"].result
    db1_ro_username  = "db1_ro_user"
    db1_ro_password  = random_password.passwords["db1_ro_user"].result
    db2_rw_useranme  = "db2_rw_user"
    db2_rw_password  = random_password.passwords["db2_rw_user"].result
  }

  extra_vars = merge({
    region = var.region
    ansible_python_interpreter = "/usr/bin/python3"
    rds_endpoint = var.rds_endpoint
    rds_admin_username = var.rds_admin_username
    rds_admin_password = var.rds_admin_password
    environment_name = var.environment_name
  }, local.users)
}

resource "ansible_playbook" "playbook" {
  playbook   = "Ansible/playbooks/main.yml"
  name       = "localhost"
  replayable = true

  extra_vars = local.extra_vars
}

output "ansible_playbook" {
  value = ansible_playbook.playbook.ansible_playbook_stdout
}