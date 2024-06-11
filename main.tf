# Define the AWS provider and region
provider "aws" {
  region = "eu-central-1"
}

# Define a security group for the SFTP server
resource "aws_security_group" "sftp_security_group" {
  name_prefix = "sftp-sg"
  description = "Security group for SFTP server"

  # Allow inbound traffic on port 15955 from a specific IP address
  ingress {
    from_port   = 15955
    to_port     = 15955
    protocol    = "tcp"
    cidr_blocks = ["91.105.0.35/32"]
  }

 # Allow outbound traffic on port 15955 from a specific IP address
  egress {
    from_port   = 15955
    to_port     = 15955
    protocol    = "tcp"
    cidr_blocks = ["91.105.0.35/32"]
  }

  # Allow outbound traffic on port 80 (HTTP)
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic on port 443 (HTTPS)
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define the EC2 instance
resource "aws_instance" "sftp_server" {
  ami                    = "ami-0395dbe049c244491" # Ubuntu in Frankfurt
  instance_type          = "t2.micro"             # Small instance type for low traffic
  key_name               = "hermane_key"          # Key pair for SSH access
  iam_instance_profile   = "role-d4ml-cloud9-deployment"  # IAM role for S3 access

  # Associate the instance with the security group created earlier
  vpc_security_group_ids = [aws_security_group.sftp_security_group.id]

  tags = {
    Name = "Ilze_Hermane_D4ML_2"  # Tag for easy identification
  }
}
