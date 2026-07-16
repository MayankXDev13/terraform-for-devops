output "instance_id" {
  description = "Spot instance ID"
  value       = aws_instance.spot.id
}

output "public_ip" {
  description = "Public IP of the spot instance"
  value       = aws_instance.spot.public_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.spot_sg.id
}

output "vpc_id" {
  description = "Default VPC ID used"
  value       = data.aws_vpc.default.id
}