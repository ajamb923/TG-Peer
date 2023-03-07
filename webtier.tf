/*  Launch EC2 instance in vpcA   */
#----------------------------------#

resource "aws_instance" "vpcA-ec2" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[0]
  user_data         = file("vpcA-userdata.sh")

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.vpcA-NIC1.id
  }

  key_name = var.key_name
  tags = {
    Name = "ec2vpcA"
  }

  depends_on = [aws_eip.vpcA-EIP1]
}




/*  Launch EC2 instance in vpcB   */
#----------------------------------#
resource "aws_instance" "vpcB-ec2" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[1]
  user_data         = file("vpcB-userdata.sh")

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.vpcB-NIC1.id
  }

  key_name = var.key_name
  tags = {
    Name = "ec2vpcB"
  }

  depends_on = [aws_eip.vpcB-EIP1]
}



/*  Launch EC2 instance in vpcC   */
#----------------------------------#

resource "aws_instance" "vpcC-ec2" {
  ami               = var.ami2
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[2]
  user_data         = file("vpcC-userdata.sh")

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.vpcC-NIC1.id
  }

  key_name = "Ohio_KP"
  tags = {
    Name = "ec2vpcC"
  }

  depends_on = [aws_eip.vpcC-EIP1]
  provider   = aws.other_region
}



/*  Launch EC2 instance in vpcD   */
#----------------------------------#

resource "aws_instance" "vpcD-ec2" {
  ami               = var.ami2
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[3]
  user_data         = file("vpcD-userdata.sh")

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.vpcD-NIC1.id
  }

  key_name = "Ohio_KP"
  tags = {
    Name = "ec2vpcD"
  }

  depends_on = [aws_eip.vpcD-EIP1]
  provider   = aws.other_region
}
