terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

# Configure the IBM Provider
provider "ibm" {
  region = "${var.ibm_region}"
  ibmcloud_api_key = var.ibmcloud_api_key
}



//VSI

resource "ibm_is_ssh_key" "testacc_vpc" {
  name       = "testacc-vpc-ssh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCKVmnMOlHKcZK8tpt3MP1lqOLAcqcJzhsvJcjscgVERRN7/9484SOBJ3HSKxxNG5JN8owAjy5f9yYwcUg+JaUVuytn5Pv3aeYROHGGg+5G346xaq3DAwX6Y5ykr2fvjObgncQBnuU5KHWCECO/4h8uWuwh/kfniXPVjFToc+gnkqA+3RKpAecZhFXwfalQ9mMuYGFxn+fwn8cYEApsJbsEmb0iJwPiZ5hjFC8wREuiTlhPHDgkBLOiycd20op2nXzDbHfCHInquEe/gYxEitALONxm0swBOwJZwlTDOB7C6y2dzlrtxr1L59m7pCkWI4EtTRLvleehBoj3u7jB4usR"
}

resource "ibm_is_instance" "testacc_vpc" {
  name    = "testacc-vpc-instance"
  image   = "r006-d806e4b3-ac71-4274-b4e2-8efc5bb75393"
  profile = "bx2-2x8"
  metadata_service_enabled  = false

  primary_network_interface {
    subnet = "${var.subnet}"
    primary_ipv4_address = "10.0.1.6"
    allow_ip_spoofing = true
  }

  network_interfaces {
    name   = "eth1"
    subnet = "${var.subnet}"
    allow_ip_spoofing = false
  }

  vpc  = "${var.vpc}"
  zone = "${var.ibm_region}-1"
  keys = [ibm_is_ssh_key.testacc_vpc.id]

  //User can configure timeouts
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
// primary_ipv4_address deprecation 
output "primary_ipv4_address" {
  value = ibm_is_instance.testacc_vpc.primary_network_interface.0.primary_ip.0.address // use this instead 
}