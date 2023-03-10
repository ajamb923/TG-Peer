
/*  Create Security Group for instances to allow port 22,80, & 443 - VPC A  */
#----------------------------------------------------------------------------#

resource "aws_security_group" "vpcA-websg" {
  name        = "vpcA_instance_SG"
  description = "Allow SSH,HTTP,HTTPS,ICMP"
  vpc_id      = aws_vpc.vpcA.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["2.0.0.0/16", "3.0.0.0/16", "4.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCA_Instance_SG_WEB"
  }

  #depends_on = [aws_vpc.vpcA]
}




/*  Create Security Group for instances to allow port 22,80, & 443 - VPC B   */
#-----------------------------------------------------------------------------#

resource "aws_security_group" "vpcB-websg" {
  name        = "vpcB_instance_SG"
  description = "Allow SSH,HTTP,HTTPS,ICMP"
  vpc_id      = aws_vpc.vpcB.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["1.0.0.0/16", "3.0.0.0/16", "4.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCB_Instance_SG_WEB"
  }

  #depends_on = [aws_vpc.vpcB]
}



/*  Create Security Group for instances to allow port 22,80, & 443 - VPC C  */
#----------------------------------------------------------------------------#

resource "aws_security_group" "vpcC-websg" {
  name        = "vpcC_instance_SG"
  description = "Allow SSH,HTTP,HTTPS,ICMP"
  vpc_id      = aws_vpc.vpcC.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["1.0.0.0/16", "2.0.0.0/16", "4.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCC_Instance_SG_WEB"
  }

  #depends_on = [aws_vpc.vpcD]
  provider   = aws.other_region
}



/*  Create Security Group for instances to allow port 22,80, & 443 - VPC D  */
#----------------------------------------------------------------------------#

resource "aws_security_group" "vpcD-websg" {
  name        = "vpcD_instance_SG"
  description = "Allow SSH,HTTP,HTTPS,ICMP"
  vpc_id      = aws_vpc.vpcD.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["1.0.0.0/16", "2.0.0.0/16", "3.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCD_Instance_SG_WEB"
  }

  #depends_on = [aws_vpc.vpcC]
  provider   = aws.other_region
}


