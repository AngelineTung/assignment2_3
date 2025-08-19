data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]                       # official Amazon images

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]            # Amazon Linux 2023, x86_64
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}


data "aws_vpcs" "candidates" {
  filter {
    name   = "tag:Name"
    values = ["ce11-tf-vpc-*"]    # wildcard OK here
  }
}

locals {
  chosen_vpc_id = element(sort(data.aws_vpcs.candidates.ids), 0)
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [local.chosen_vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*-public-*"]
  }
}

locals {
  chosen_public_subnet_id = element(sort(data.aws_subnets.public.ids), 0)
}