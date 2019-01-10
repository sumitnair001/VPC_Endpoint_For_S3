# main.tf 
# Input values for provider and create a VPC
provider "aws" {
        region     = "${var.region}"
        profile    = "${var.profile}"
} # end provider
# create the VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}" 
  enable_dns_support   = "${var.dnsSupport}" 
  enable_dns_hostnames = "${var.dnsHostNames}"
tags {
    Name = "My VPC"
  }
} # end resource
# create the Subnet
resource "aws_subnet" "My_VPC_Subnet_Public" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = "${var.subnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "My VPC Public Subnet"
  }
} # end resource
resource "aws_subnet" "My_VPC_Subnet_Private" {
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  cidr_block              = "${var.subnetCIDRblock1}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
  map_public_ip_on_launch =  "false"
tags = {
   Name = "My VPC Private Subnet"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "My_VPC_Security_Group_Private" {
  vpc_id       = "${aws_vpc.My_VPC.id}"
  name         = "My VPC Security Group Private"
  description  = "My VPC Security Group Private"
ingress {
    cidr_blocks = "${var.ingressCIDRblockPriv}"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = "${var.ingressCIDRblockPriv}"  
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
tags = {
        Name = "My VPC Security Group Private"
  }
} 
resource "aws_security_group" "My_VPC_Security_Group_Public" {
  vpc_id       = "${aws_vpc.My_VPC.id}"
  name         = "My VPC Security Group Public"
  description  = "My VPC Security Group Public"
ingress {
    cidr_blocks = "${var.ingressCIDRblockPub}"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = "${var.ingressCIDRblockPub}"  
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
tags = {
        Name = "My VPC Security Group Public"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "My_VPC_GW" {
  vpc_id = "${aws_vpc.My_VPC.id}"
tags {
        Name = "My VPC Internet Gateway"
    }
} # end resource
# Create the Route Table
resource "aws_route_table" "My_VPC_route_table" {
    vpc_id = "${aws_vpc.My_VPC.id}"
tags {
        Name = "My VPC Route Table"
    }
} # end resource
# Create the Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id        = "${aws_route_table.My_VPC_route_table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.My_VPC_GW.id}"
} # end resource
# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association" {
    subnet_id      = "${aws_subnet.My_VPC_Subnet_Public.id}"
    route_table_id = "${aws_route_table.My_VPC_route_table.id}"
} # end resource

#create S3 bucket
resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "VPC_EndPoint_test"
  }
}