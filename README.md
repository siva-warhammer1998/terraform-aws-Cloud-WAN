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

## 🔧 Input Variables

| Name                   | Type          | Required | Default                                    | Description                                                   |
|------------------------|---------------|----------|--------------------------------------------|---------------------------------------------------------------|
| global_network_description | string     | No       | "AWS Network Manager Global Network"       | Description of the Global Network                             |
| core_network_description   | string     | No       | "AWS Network Manager Core Network"         | Description of the Core Network                               |
| use_custom_policy          | bool       | No       | false                                      | Use a custom JSON policy document instead of generated one    |
| custom_policy_document     | string     | No       | ""                                         | Raw JSON string or path to the policy file                    |
| segments                  | list(object) | Yes     | N/A                                        | List of segments with `name` and `edge_locations`             |
| asn_ranges                | list(object) | Yes     | N/A                                        | ASN ranges with `region` and `asn_range`                      |
| edge_locations            | list(object) | Yes     | N/A                                        | List of edge location objects (with `location`)               |
| segment_actions           | list(object) | No      | []                                         | Actions between segments (e.g., auto-accept)                  |
| attachment_policies       | list(object) | No      | []                                         | Attachment rules based on tags or conditions                  |
| shared_segments           | list(object) | No      | []                                         | Segment sharing definitions with permitted actions            |

---

## 📤 Outputs

| Name                              | Description                                  |
|-----------------------------------|----------------------------------------------|
| global_network_id                 | ID of the Global Network                     |
| core_network_id                   | ID of the Core Network                       |
| core_network_arn                  | ARN of the Core Network                      |
| core_network_policy_attachment_id | ID of the Core Network Policy Attachment     |

---

## 🧪 Example `terraform.tfvars`

```hcl
global_network_description = "My Global WAN"
core_network_description   = "My Core Network"

use_custom_policy = false

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

segment_actions = [
  {
    action  = "auto-accept"
    segment = "prod"
  }
]

attachment_policies = [
  {
    rule_number     = 100
    condition_logic = "AND"
    conditions = [
      {
        type  = "tag"
        key   = "env"
        value = "prod"
      }
    ]
    action = {
      association_method = "constant"
      segment            = "prod"
    }
  }
]

shared_segments = [
  {
    name       = "prod"
    share_with = [
      {
        type  = "ACCOUNT"
        value = "123456789012"
      }
    ]
    permitted_actions = ["CREATE_ATTACHMENT"]
  }
]
