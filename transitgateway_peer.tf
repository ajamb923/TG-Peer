
/*  Create Transit Gateway 2 - Propagation to Transit Gateway Route Table for vpcD  */
#------------------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_peering_attachment" "tg-peer" {
  peer_region             = "us-east-2"
  peer_transit_gateway_id = aws_ec2_transit_gateway.tg2.id
  transit_gateway_id      = aws_ec2_transit_gateway.tg1.id

  tags = {
    Name = "TGW Peering Requestor"
  }
}


/*  Create Transit Gateway Peer - Auto Accept  */
#-----------------------------------------------#
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "tg2-accept-tg1" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.tg-peer.id

  tags = {
    Name = "Auto-Accepter"
  }

  provider = aws.other_region
}




/*  Create Transit Gateway Peer - TG1 - Association to Transit Gateway Route Table for TG Peer */
#-----------------------------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route_table_association" "tg1-peer-assocc-vpc1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg-peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg1-RT.id

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.tg2-accept-tg1
  ]
}

/*  Create Transit Gateway Peer - TG2 - Association to Transit Gateway Route Table for TG Peer */
#-----------------------------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route_table_association" "tg1-peer-assocc-vpc2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg-peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id

  provider = aws.other_region

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.tg2-accept-tg1
  ]
}





/*  Create Transit Gateway 1 - Static Route for vpcA & vpcB in other region 2  */
#-----------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route" "tg2-static-route-vpcA" {
  destination_cidr_block         = "1.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg-peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id

  provider = aws.other_region

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.tg2-accept-tg1
  ]
}
 
resource "aws_ec2_transit_gateway_route" "tg2-static-route-vpcB" {
  destination_cidr_block         = "2.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg-peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg2-RT.id

  provider = aws.other_region

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.tg2-accept-tg1
  ]
}




/*  Create Transit Gateway 1 - Static Route for vpcC & vpcD in other region 1 */
#-----------------------------------------------------------------------------#

resource "aws_ec2_transit_gateway_route" "tg2-static-route-vpcC" {
  destination_cidr_block         = "3.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg-peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg1-RT.id

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.tg2-accept-tg1
  ]
}
 
resource "aws_ec2_transit_gateway_route" "tg2-static-route-vpcD" {
  destination_cidr_block         = "4.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg-peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg1-RT.id

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.tg2-accept-tg1
  ]
}