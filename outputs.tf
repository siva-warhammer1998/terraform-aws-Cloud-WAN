output "global_network_id" {
  description = "ID of the AWS Network Manager Global Network"
  value       = aws_networkmanager_global_network.global_network_main.id
}

output "core_network_id" {
  description = "ID of the AWS Network Manager Core Network"
  value       = aws_networkmanager_core_network.core_network_main.id
}

output "core_network_arn" {
  description = "ARN of the AWS Network Manager Core Network"
  value       = aws_networkmanager_core_network.core_network_main.arn
}

output "core_network_policy_attachment_id" {
  description = "ID of the Core Network Policy Attachment"
  value       = aws_networkmanager_core_network_policy_attachment.core_network_policy_attachment.id
}
