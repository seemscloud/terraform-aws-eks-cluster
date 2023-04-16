output "key_pair_names" {
  value = aws_key_pair.deployer.*.key_name
}