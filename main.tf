resource "aws_instance" "public" {
  count                       = var.instance_count
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type

  # Both instances go to the SAME subnet
  subnet_id                   = local.chosen_public_subnet_id

  associate_public_ip_address = true
  key_name                    = "angeline-key-pair"
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  tags = {
    Name = format("%s-ec2-%02d", var.name, count.index + 1)
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "angeline-terraform-security-group"#Security group name, e.g. jazeel-terraform-security-group
  description = "Allow SSH inbound"  
  vpc_id      = local.chosen_vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  
}
