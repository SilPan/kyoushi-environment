# Intranet Hosts

## Internal Employees 
module "internal_employees" {
  source                   = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec-count.git?ref=v1.3"
  host_capacity            = var.employee_capacity
  hostname                 = "internal_employee"
  tag                      = "employee"
  host_address_start_index = var.employee_ip_start_index
  image                    = local.employee_image
  flavor                   = local.employee_flavor
  sshkey                   = var.sshkey
  network                  = var.intranet
  subnet                   = var.intranet_subnet
  userdatafile             = local.employee_userdata_file
  userdata_vars            = local.employee_userdata_vars
}

module "intranet" {
  source             = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.3"
  hostname           = "intranet"
  host_address_index = var.intranet_ip_index
  image              = local.intranet_image
  flavor             = local.intranet_flavor
  sshkey             = var.sshkey
  network            = var.intranet
  subnet             = var.intranet_subnet
  userdatafile       = local.intranet_userdata_file
  userdata_vars      = local.intranet_userdata_vars
}

module "shares" {
  count              = length(var.shares)
  source             = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.3"
  hostname           = "${var.shares[count.index].name}_share"
  host_address_index = var.shares[count.index].ip_index
  tag                = "share"
  image              = local.share_image
  flavor             = local.share_flavor
  sshkey             = var.sshkey
  network            = var.intranet
  subnet             = var.intranet_subnet
  userdatafile       = local.share_userdata_file
  userdata_vars      = local.share_userdata_vars
}