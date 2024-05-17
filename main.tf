###======= Create VPC in AWS ==========###
resource "aws_vpc" "group_3_vpc" {

  cidr_block       = var.group_3_vpc
  tags = {
    Name = "group_3_vpc"
  }

}



###======== Create Subnet depends on the above VPC implicitly ====###
resource "aws_subnet" "group_3_subnet" {

  vpc_id           = aws_vpc.group_3_vpc.id
  cidr_block = var.group_3_subnet

  tags = {
    Name = "group_3_subnet"
  }

}



###======= Create key_pair to access the instance =====##
resource "aws_key_pair" "group_3_key" {

  key_name   = "group_3_key"
  public_key = var.pub_key

}



###======= Create New Instance with the above subnet =========###
resource "aws_instance" "group_3_instance" {

  ami                     = "ami-04b70fa74e45c3917"
  instance_type           = "t2.micro"
  subnet_id     = aws_subnet.group_3_subnet.id
  private_ip = var.private_ip_group_3_instance
  key_name = aws_key_pair.group_3_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "group_3_instance" 
  }

}

# ###================== Create subnet in the default vpc ==================###

data "aws_vpc" "default_vpc" {
 
 default = true
  
}

resource "aws_subnet" "data_subnet" {

  vpc_id            = data.aws_vpc.default_vpc.id
  cidr_block        = cidrsubnet(data.aws_vpc.default_vpc.cidr_block, 4, 1)

}
