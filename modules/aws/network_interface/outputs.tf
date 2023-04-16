output "network_interface_ids" {
  value = aws_network_interface.network_interface.*.id
}