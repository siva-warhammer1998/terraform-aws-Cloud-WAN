resource "aws_networkmanager_global_network" "global_network_main" {
  description = var.global_network_description
}

resource "aws_networkmanager_core_network" "core_network_main" {
  global_network_id = aws_networkmanager_global_network.global_network_main.id
  description       = var.core_network_description
}

resource "aws_networkmanager_core_network_policy_attachment" "core_network_policy_attachment" {
  core_network_id = aws_networkmanager_core_network.core_network_main.id

  policy_document = var.use_custom_policy ? var.custom_policy_document : templatefile("${path.module}/policy.json.tpl", {
    segments            = var.segments
    asn_ranges          = var.asn_ranges
    edge_locations      = var.edge_locations
    segment_actions     = var.segment_actions
    attachment_policies = var.attachment_policies
    shared_segments     = var.shared_segments
  })
}
