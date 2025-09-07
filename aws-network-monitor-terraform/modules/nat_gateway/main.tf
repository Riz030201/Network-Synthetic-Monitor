variable "vpc_id" {}
variable "public_subnet_id" {}

resource "aws_eip" "nat" {
  tags = { Name = "net-monitor-natgw-eip" }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id
  tags = { Name = "net-monitor-natgw" }
}

resource "aws_route" "private_nat" {
  route_table_id         = data.aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

data "aws_route_table" "private" {
  filter {
    name   = "tag:Name"
    values = ["net-monitor-private-rt"]
  }
  vpc_id = var.vpc_id
}