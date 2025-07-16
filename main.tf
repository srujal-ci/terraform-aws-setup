resource "aws_key_pair" "my_demo_key" {
  key_name   = "my-demo"
  public_key = file("terra-key-ec2.pub")
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "demo-tf-sg" {
  name   = "allow_tls"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "my-demo-ec2-instance" {
  key_name               = aws_key_pair.my_demo_key.key_name
  vpc_security_group_ids = [aws_security_group.demo-tf-sg.id]
  instance_type          = each.value
  ami                    = var.ec2_ami
  user_data              = file("install_nginx.sh")

  for_each = tomap({
    Demo-EC2-micro  = "t2.micro",
    Demo-EC2-medium = "t2.medium"
  })
  root_block_device {
    volume_size           = var.ec2_root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    environment = "testing"
    Name        = each.key
  }


}




