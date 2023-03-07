/*  Create Transit Gateway 2   */
#-------------------------------#

resource "aws_ec2_transit_gateway" "tg2" {
  description                     = "Transit gateway for vpcC & vpcD"
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "TransitGateway-2"
  }

  provider = aws.other_region
}


/*  Create Transit Gateway 2 - Route Table  */
#--------------------------------------------#

resource "aws_ec2_transit_gateway_route_table" "tg2-RT" {
  transit_gateway_id = aws_ec2_transit_gateway.tg2.id
  #default_association_route_table = "true"
  #default_association_propagation_route_table = "true"

  tags = {
    Name = "TransitGateway2-RT"
  }

  provider = aws.other_region
}





/*  Create Transit Gateway 2 - Attachment for vpcC  */
#----------------------------------------------------#

resource "aws_ec2_transit_gateway_vpc_attachment" "tg2-attach-vpcC" {
  subnet_ids         = [aws_subnet.vpcC-websubnet1.id]
  transit_gateway_id = aws_ec2_transit_gateway.tg2.id
  vpc_id             = aws_vpc.vpcC.id

  tags = {
    Name = "tg2-attach-vpcC"
  }

  provider = aws.other_region
}


/*  Create Transit Gateway 2 - Attachment for vpcD  */
#----------------------------------------------------#

resource "aws_ec2_transit_gateway_vpc_attachment" "tg2-attach-vpcD" {
  subnet_ids         = [aws_subnet.vpcD-websubnet1.id]
  transit_gateway_id = aws_ec2_transit_gateway.tg2.id
  vpc_id             = aws_vpc.vpcD.id

  tags = {
    Name = "tg2-attach-vpcD"
  }

  provider = aws.other_region
}






/*  Create Transit Gateway 2 - Association to Transit Gateway Route Table for vpcC  */
#------------------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route_table_association" "tg2-assocc-vpcC" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tg2-attach-vpcC.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id

  provider = aws.other_region
}



/*  Create Transit Gateway 2 - Association to Transit Gateway Route Table for vpcD  */
#------------------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route_table_association" "tg2-assocc-vpcD" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tg2-attach-vpcD.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id

  provider = aws.other_region
}





/*  Create Transit Gateway 2 - Propagation to Transit Gateway Route Table for vpcC  */
#------------------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route_table_propagation" "tg2-propag-vpcC" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tg2-attach-vpcC.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id

  provider = aws.other_region
}

/*  Create Transit Gateway 2 - Propagation to Transit Gateway Route Table for vpcD  */
#------------------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route_table_propagation" "tg2-propag-vpcD" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tg2-attach-vpcD.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id

  provider = aws.other_region
}




/*  Create Transit Gateway 1 - Route for vpcC  
#-----------------------------------------------#

resource "aws_ec2_transit_gateway_route" "tg2-route-vpcC" {
  destination_cidr_block         = "1.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tg2-attach-vpcD.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id
}


/*  Create Transit Gateway 1 - Route for vpcD  
#-----------------------------------------------#

resource "aws_ec2_transit_gateway_route" "tg2-route-vpcD" {
  destination_cidr_block         = "2.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tg2-attach-vpcC.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id
}

# Ended up not having to create these Routes since routes will be created after propagation*/