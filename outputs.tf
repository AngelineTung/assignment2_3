# When your resource is aws_instance.public_each with for_each
output "public_ips_by_name" {
  value = { for k, i in aws_instance.public : k => i.public_ip }
}