{
    "version": "2021-01-01",
    "core-network-configuration": {
      "asn-ranges": ${jsonencode(asn_ranges)},
      "edge-locations": ${jsonencode(edge_locations)}
    },
    "segments": ${jsonencode(segments)},
    "segment-actions": ${jsonencode(segment_actions)},
    "attachment-policies": ${jsonencode(attachment_policies)},
    "shared-segments": ${jsonencode(shared_segments)}
  }
  