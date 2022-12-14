variable "ibmcloud_api_key" {
    type = string
    sensitive = true
}

variable "ibm_region" {
    type = string
}

variable "subnet" {
    type = string
}

variable "ssh_key_name" {
    type = string
}

variable "ssh_key_public_key" {
    sensitive = true
    type = string
}

variable "vpc" {
    type = string
}

variable "image_id" {
    type = string
}

variable "vsi_name" {
    type = string
}

variable "vsi_profile" {
    type = string
}

output "vsi_id" {
    value = ibm_is_instance.testacc_vpc.id
}
