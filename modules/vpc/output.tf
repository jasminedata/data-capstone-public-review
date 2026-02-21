# Output value: vpc_id.
output "vpc_id" {
  value = aws_vpc.this.id
}

# Output value: public_subnet_ids.
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

# Output value: private_subnet_ids.
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

# Output value: public_route_table_id.
output "public_route_table_id" {
  value = aws_route_table.public.id
}

# Output value: private_route_table_id.
output "private_route_table_id" {
  value = aws_route_table.private.id
}
