resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.My_VPC.id}"
  service_name = "com.amazonaws.ap-south-1.s3"
  
}
# associate route table with VPC endpoint
resource "aws_vpc_endpoint_route_table_association" "route_table_association" {
  route_table_id  = "${aws_route_table.My_VPC_route_table.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
}