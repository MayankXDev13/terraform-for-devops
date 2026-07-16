output "public_ip" {
  value = aws_instance.spot.public_ip
}

output "instance_id" {
  value = aws_instance.spot.id
}