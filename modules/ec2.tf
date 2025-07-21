data "aws_ami" "amzon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-*-x86_64"]
  }
}

resource "aws_instance" "public" {
  count = var.public_ec2_num

  subnet_id              = aws_subnet.public.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.public.id]
  ami                    = data.aws_ami.amzon_linux_2023.id
}
