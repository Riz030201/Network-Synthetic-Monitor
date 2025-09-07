output "eip" {
  value = aws_eip.nat.public_ip
}
output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}