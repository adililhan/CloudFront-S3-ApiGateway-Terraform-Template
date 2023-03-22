data "aws_vpc" "vpc" {
  tags = {
    Name        = "infra-${var.environment}-vpc"
    environment = var.environment
  }
}

data "aws_subnet" "private_subnet" {
  tags = {
    Name        = "infra-${var.environment}-private"
    environment = var.environment
  }
}

data "archive_file" "zip_file" {
  type        = "zip"
  output_path = var.output_path
  source_dir  = var.source_dir
}

data "aws_security_group" "infra_common_sg" {
  tags = {
    Name = "infra-${var.environment}-common-sg"
  }
}
