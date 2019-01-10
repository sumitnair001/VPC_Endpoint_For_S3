resource "aws_instance" "public_instance" {
  ami           = "${var.public_instance}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.My_VPC_Subnet_Public.id}"
  key_name = "Jan2019" # insert your key file name here

  tags = {
    Name = "public_instance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "${var.private_instance}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.My_VPC_Subnet_Private.id}"
key_name = "Jan2019" # insert your key file name here

  tags = {
    Name = "private_instance" 
  }
}