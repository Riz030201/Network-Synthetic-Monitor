variable "vpc_id" {}

resource "aws_security_group" "monitor" {
  name        = "net-monitor-sg"
  description = "Security group for network monitor"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "net-monitor-sg" }
}