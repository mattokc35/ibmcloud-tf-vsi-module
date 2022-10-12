variable "ibmcloud_api_key" {
    type = string
    sensitive = true
}

variable "ibm_region" {
    type = string
    default = "us-south"
}

variable "subnet" {
    type = string
}

variable "vpc" {
    type = string
}
