output "ec2_public_ip" {
  value       = aws_instance.my-instance.public_ip # interpolation
  description = "Public IP address of EC2 instance"
}

output "ec2_public_dns" {
  value       = aws_instance.my-instance.public_dns
  description = "Public DNS name of EC2 instance"
}

output "ec2_private_ip" {
  value       = aws_instance.my-instance.private_ip
  description = "Private IP address of EC2 instance"
}

output "ec2_private_dns" {
  value       = aws_instance.my-instance.private_dns
  description = "Private DNS name of EC2 instance"
}

output "ec2_ami_id" {
  value       = aws_instance.my-instance.ami
  description = "AMI ID of EC2 instance"
}
  
