data "terraform_remote_state" "virtual_network" {
  backend = "remote"
  
  config = {
    organization = "np-gw-elf"
    workspaces = {
      name = "terraformtest"
    }
  }
}