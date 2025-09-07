# AWS Network Monitor Terraform

This repository provisions AWS infrastructure for a CloudWatch Network Monitor using Terraform in the **us-west-2** region. It creates the following resources:

- VPC with public and private subnets (us-west-2)
- Security Group (us-west-2)
- NAT Gateway (us-west-2)
- IAM Role (us-west-2)
- CloudWatch Network Monitor (synthetic monitor)

## Architecture Diagram (Lucidchart Template)

Below is a suggested Lucidchart template layout for your AWS Network Monitor architecture. You can recreate this in Lucidchart using AWS official icons and export it as `architecture.png` to include in your repo.

```
+-------------------------------------------------------------+
|                  VPC (us-west-2)                            |
|                                                             |
|   +-------------------+   +-------------------+             |
|   |  Public Subnet    |   |  Private Subnet   |             |
|   |  [NAT Gateway]    |   | [Network Monitor] |             |
|   +-------------------+   +-------------------+             |
|                             |                               |
|                        [Security Group]                     |
|                             |                               |
|                        [IAM Role]                           |
+-------------------------------------------------------------+
         |                                              
         v                                              
   Internet / Your Laptop (69.243.191.96)              
```

**Legend:**
- All resources are created in **us-west-2**.
- VPC contains public and private subnets.
- NAT Gateway is in the public subnet.
- CloudWatch Network Monitor is in the private subnet.
- Security Group and IAM Role are associated with the monitor.
- Synthetic probe targets your laptop’s public IP.

**How to use this template:**
1. Open [Lucidchart](https://www.lucidchart.com/).
2. Search for "AWS" in the shape library and drag the appropriate icons into your diagram.
3. Arrange the resources as shown above.
4. Export the diagram as `architecture.png` and add it to your repo.
5. Reference the image in this README:
   ```
   ![AWS Network Monitor Architecture](architecture.png)
   ```

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html)
- AWS account and credentials with permissions to create VPC, EC2, IAM, and CloudWatch resources in **us-west-2**

## Usage
1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd aws-network-monitor-terraform
   ```
2. **Configure variables:**
   Edit `terraform.tfvars` and provide your values for:
   - `laptop_ip` (your public IP)
   - `iam_role_arn` (IAM role ARN)
   - `private_subnet_id`, `security_group_id`, `vpc_id` (if not created by Terraform)

3. **Initialize Terraform:**
   ```sh
   terraform init
   ```
4. **Plan and apply:**
   ```sh
   terraform plan
   terraform apply
   ```

## Manual Step: Create CloudWatch Synthetic Monitor via AWS Console
After running Terraform, follow these steps to manually create a CloudWatch Network Monitor in **us-west-2**:

1. Go to the AWS Console and switch to the **us-west-2** region.
2. Navigate to **CloudWatch > Network Monitor**.
3. Click **Create monitor**.
4. Fill in the required details:
   - **Monitor name:** e.g., `laptop-net-monitor`
   - **VPC ID:** Use the VPC created in us-west-2
   - **Subnet ID:** Use the private subnet created in us-west-2
   - **Security Group ID:** Use the security group created in us-west-2
   - **IAM Role ARN:** Use the IAM role created in us-west-2
   - **Probe destination:** Enter your laptop’s public IP (e.g., `69.243.191.96`) and select protocol (ICMP)
   - **Probe interval, timeout, and failure threshold:** Set as needed (e.g., interval 30s, timeout 5s, threshold 3)
5. Review and create the monitor.
6. Verify the monitor status and metrics in CloudWatch.

## Module Structure
- `modules/vpc`: VPC, subnets, route tables (us-west-2)
- `modules/security_group`: Security group for monitor (us-west-2)
- `modules/nat_gateway`: NAT gateway for private subnet (us-west-2)
- `modules/iam_role`: IAM role for CloudWatch Network Monitor (us-west-2)
- `modules/network_monitor`: CloudWatch Network Monitor resource (us-west-2)

## Troubleshooting
- Ensure your IAM user/role has permissions for EC2, IAM, and CloudWatch actions in **us-west-2**.
- If you encounter trust policy errors, check the AWS documentation for the correct service principal.
- For manual monitor creation, see the AWS Console > CloudWatch > Network Monitor in **us-west-2**.

## License
MIT
