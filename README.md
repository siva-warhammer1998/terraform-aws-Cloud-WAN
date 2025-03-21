# terraform-aws-cloud-wan

A Terraform module to create an AWS Cloud WAN Global Network and Core Network, with support for attaching a network policy. This module supports both auto-generated basic policies and custom full policy documents.

---

## 🚀 Features

- Creates a **Global Network** and **Core Network** using AWS Network Manager
- Supports defining:
  - Segments
  - ASN ranges
  - Edge locations
  - Segment actions
  - Attachment policies
  - Shared segments
- Optional support for user-defined **custom Cloud WAN policy documents**
- Clean, modular input variables with default values

---

## 📦 Usage

### ✅ Basic Example

```hcl
module "cloud_wan" {
  source = "github.com/<your-org>/terraform-aws-cloud-wan"

  global_network_description = "My Global WAN"
  core_network_description   = "My Core Network"

  segments = [
    {
      name           = "prod"
      edge_locations = ["us-east-1", "us-west-2"]
    }
  ]

  asn_ranges = [
    {
      region    = "us-east-1"
      asn_range = "64512-64520"
    }
  ]

  edge_locations = [
    { location = "us-east-1" },
    { location = "us-west-2" }
  ]
}
