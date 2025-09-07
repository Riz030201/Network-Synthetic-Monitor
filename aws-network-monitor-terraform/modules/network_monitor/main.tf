variable "private_subnet_id" {}
variable "security_group_id" {}
variable "iam_role_arn" {}
variable "laptop_ip" {}

resource "null_resource" "network_monitor" {
  provisioner "local-exec" {
    command = <<EOT
      aws cloudwatch network-monitor create-monitor \
        --region us-west-2 \
        --monitor-name laptop-net-monitor \
        --vpc-id ${var.vpc_id} \
        --subnet-ids ${var.private_subnet_id} \
        --security-group-ids ${var.security_group_id} \
        --role-arn ${var.iam_role_arn} \
        --probe-destinations '[{"address":"${var.laptop_ip}","protocol":"ICMP"}]' \
        --probe-interval 30 \
        --probe-timeout 5 \
        --probe-failure-threshold 3
    EOT
  }
}