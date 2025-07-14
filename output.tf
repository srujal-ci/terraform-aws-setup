output "ec2_pubic_dns" {
  value = aws_instance.my-demo-ec2-instance.public_dns
}

output "ec2_pubic_ip" {
  value = aws_instance.my-demo-ec2-instance.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.my-demo-ec2-instance.private_ip
}
