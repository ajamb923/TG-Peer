/*  Create 2 VPCs in us-east-2 region  */
#-------------------------------------------------------------------#

#
#
#
#
#


/*  Create VPC D   */
#-----------------#

resource "aws_vpc" "vpcD" {
  cidr_block           = "4.0.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "VPC-D"
  }

  provider = aws.other_region
}



/*  Create IGW  */
#----------------#

resource "aws_internet_gateway" "vpcD-IGW" {
  vpc_id = aws_vpc.vpcD.id

  tags = {
    Name = "VPC-D-IGW"
  }

  depends_on = [aws_vpc.vpcD]
  provider   = aws.other_region
}



/*  Create Webtier Route Table  */
#--------------------------------#

resource "aws_route_table" "vpcD-webtier-route-table" {
  vpc_id = aws_vpc.vpcD.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpcD-IGW.id
  }

  route {
    cidr_block = "3.0.0.0/16"
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
    Name = "VPC-D_WEB_RT"
  }

  depends_on = [aws_vpc.vpcD, aws_ec2_transit_gateway.tg2]
  provider   = aws.other_region
}


/*  Create a Subnets  */
#---------------------#

resource "aws_subnet" "vpcD-websubnet1" {
  vpc_id            = aws_vpc.vpcD.id
  cidr_block        = var.subnet_cidr[3]
  availability_zone = var.availability_zone[3]

  tags = {
    Name = "vpcD-websubnet1"
  }

  provider = aws.other_region
}


/*  Associate subnet with Route Table  */
#---------------------------------------#

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.vpcD-websubnet1.id
  route_table_id = aws_route_table.vpcD-webtier-route-table.id

  provider = aws.other_region
}



/*  Create a network interface with an IP in the subnet created above  */
#-----------------------------------------------------------------------#

resource "aws_network_interface" "vpcD-NIC1" {
  subnet_id       = aws_subnet.vpcD-websubnet1.id
  private_ips     = ["4.0.40.23"]
  security_groups = [aws_security_group.vpcD-websg.id]

  provider = aws.other_region
}





/*  Assign elastic IPs to the network interfaces  */
#--------------------------------------------------#


resource "aws_eip" "vpcD-EIP1" {
  vpc                       = true
  network_interface         = aws_network_interface.vpcD-NIC1.id
  associate_with_private_ip = "4.0.40.23"
  depends_on                = [aws_internet_gateway.vpcD-IGW]

  provider = aws.other_region
}




