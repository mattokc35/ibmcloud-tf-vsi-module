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
  ibmcloud_api_key = "${var.ibmcloud_api_key}"
}



//VSI

resource "ibm_is_ssh_key" "testacc_vpc" {
  name       = "${var.ssh_key_name}"
  public_key = "${var.ssh_key_public_key}"
}

resource "ibm_is_instance" "testacc_vpc" {
  name    = "${var.vsi_name}"
  image   = "${var.vsi_image_id}"
  profile = "${var.profile}"
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
