/*  Create 2 VPCs in us-east-2 region  */
#-------------------------------------------------------------------#

#
#
#
#
#


/*  Create VPC C   */
#-----------------#

resource "aws_vpc" "vpcC" {
  cidr_block           = "3.0.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "VPC-C"
  }

  provider = aws.other_region
}



/*  Create IGW  */
#----------------#

resource "aws_internet_gateway" "vpcC-IGW" {
  vpc_id = aws_vpc.vpcC.id

  tags = {
    Name = "VPC-C-IGW"
  }

  provider = aws.other_region
}



/*  Create Webtier Route Table  */
#--------------------------------#

resource "aws_route_table" "vpcC-webtier-route-table" {
  vpc_id = aws_vpc.vpcC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpcC-IGW.id
  }

  route {
    cidr_block = "4.0.0.0/16"
    gateway_id = aws_ec2_transit_gateway.tg2.id
  }

  route {
    cidr_block = "1.0.0.0/16"
    gateway_id = aws_ec2_transit_gateway.tg2.id
  }

  route {
    cidr_block = "2.0.0.0/16"
    gateway_id = aws_ec2_transit_gateway.tg2.id
  }

  tags = {
    Name = "VPC-C_WEB_RT"
  }

  depends_on = [aws_vpc.vpcD, aws_ec2_transit_gateway.tg2]
  provider   = aws.other_region
}


/*  Create a Subnets  */
#---------------------#

resource "aws_subnet" "vpcC-websubnet1" {
  vpc_id            = aws_vpc.vpcC.id
  cidr_block        = var.subnet_cidr[2]
  availability_zone = var.availability_zone[2]

  tags = {
    Name = "vpcC-websubnet1"
  }

  provider = aws.other_region
}


/*  Associate subnet with Route Table  */
#---------------------------------------#

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.vpcC-websubnet1.id
  route_table_id = aws_route_table.vpcC-webtier-route-table.id

  provider = aws.other_region
}



/*  Create a network interface with an IP in the subnet created above  */
#-----------------------------------------------------------------------#

resource "aws_network_interface" "vpcC-NIC1" {
  subnet_id       = aws_subnet.vpcC-websubnet1.id
  private_ips     = ["3.0.30.23"]
  security_groups = [aws_security_group.vpcC-websg.id]

  provider = aws.other_region
}





/*  Assign elastic IPs to the network interfaces  */
#--------------------------------------------------#


resource "aws_eip" "vpcC-EIP1" {
  vpc                       = true
  network_interface         = aws_network_interface.vpcC-NIC1.id
  associate_with_private_ip = "3.0.30.23"
  depends_on                = [aws_internet_gateway.vpcC-IGW]

  provider = aws.other_region
}




