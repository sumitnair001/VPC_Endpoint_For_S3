# variables.tf
variable "region" {
 default = "ap-south-1"
}

variable "profile" {
  default = "default"
}

variable "public_instance" {
  type = "string"
}

variable "private_instance" {
type = "string"  
}



variable "availabilityZone" {
        default = "ap-south-1b"
}
variable "instanceTenancy" {
 default = "default"
}
variable "dnsSupport" {
 default = true
}
variable "dnsHostNames" {
        default = true
}
variable "vpcCIDRblock" {
 default = "10.0.0.0/16"
}
variable "subnetCIDRblock" {
        default = "10.0.0.0/24"
}
variable "subnetCIDRblock1" {
        default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {
        default = "0.0.0.0/0"
}
variable "ingressCIDRblockPriv" {
        type = "list"
        default = [ "0.0.0.0/0" ]
}

variable "ingressCIDRblockPub" {
        type = "list"
        default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
        default = true
}

variable "bucket_name" {
  type = "string"
}
