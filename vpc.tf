# Creating the VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}"
  }
}

#Creating the internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}
#Creating the Elastic IP
resource "aws_eip" "nat_eip" {
  vpc = true
}
# Creating the nat gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-a.id
  tags = {
    Name = "gw NAT"
  }
}

  #To ensure proper ordering, it is reccommmeded to add an explicit dependency on the Internet Gateway for the VPC.connection {
  depends_on = [aws_internet_gateway.igw]
