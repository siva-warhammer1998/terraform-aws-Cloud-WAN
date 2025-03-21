# terraform-AWS-Cloud-Wan

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
  source = "github.com/siva-warhammer1998/terraform-aws-cloud-wan"

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
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.79 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.92.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_networkmanager_core_network.core_network_main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkmanager_core_network) | resource |
| [aws_networkmanager_core_network_policy_attachment.core_network_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkmanager_core_network_policy_attachment) | resource |
| [aws_networkmanager_global_network.global_network_main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkmanager_global_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asn_ranges"></a> [asn\_ranges](#input\_asn\_ranges) | ASN ranges for each region | <pre>list(object({<br/>    region    = string<br/>    asn_range = string<br/>  }))</pre> | n/a | yes |
| <a name="input_attachment_policies"></a> [attachment\_policies](#input\_attachment\_policies) | Attachment policies to control segment assignment based on rules | <pre>list(object({<br/>    rule_number     = number<br/>    condition_logic = string<br/>    conditions = list(object({<br/>      type   = string               <br/>      key    = string<br/>      value  = string<br/>      negate = optional(bool)<br/>    }))<br/>    action = object({<br/>      association_method = string  <br/>      segment            = string<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_core_network_description"></a> [core\_network\_description](#input\_core\_network\_description) | Description of the core network | `string` | `"AWS Network Manager Core Network"` | no |
| <a name="input_custom_policy_document"></a> [custom\_policy\_document](#input\_custom\_policy\_document) | Custom policy document | `string` | n/a | yes |
| <a name="input_edge_locations"></a> [edge\_locations](#input\_edge\_locations) | Edge locations | <pre>list(object({<br/>        location = string<br/>    }))</pre> | n/a | yes |
| <a name="input_global_network_description"></a> [global\_network\_description](#input\_global\_network\_description) | Description of the global network | `string` | `"AWS Network Manager Global Network"` | no |
| <a name="input_segment_actions"></a> [segment\_actions](#input\_segment\_actions) | Defines behavior between segments (e.g., auto-accept) | <pre>list(object({<br/>    action      = string<br/>    segment     = string<br/>    description = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_segments"></a> [segments](#input\_segments) | Segments and their associated edge locations | <pre>list(object({<br/>    name                           = string<br/>    edge_locations                 = list(string)<br/>    require_attachment_acceptance = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_shared_segments"></a> [shared\_segments](#input\_shared\_segments) | Shared segments and permissions | <pre>list(object({<br/>    name           = string<br/>    share_with     = list(object({<br/>      type  = string   <br/>      value = string   <br/>    }))<br/>    permitted_actions = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_use_custom_policy"></a> [use\_custom\_policy](#input\_use\_custom\_policy) | Set to true if you want to provide your own full policy document | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_core_network_arn"></a> [core\_network\_arn](#output\_core\_network\_arn) | ARN of the AWS Network Manager Core Network |
| <a name="output_core_network_id"></a> [core\_network\_id](#output\_core\_network\_id) | ID of the AWS Network Manager Core Network |
| <a name="output_core_network_policy_attachment_id"></a> [core\_network\_policy\_attachment\_id](#output\_core\_network\_policy\_attachment\_id) | ID of the Core Network Policy Attachment |
| <a name="output_global_network_id"></a> [global\_network\_id](#output\_global\_network\_id) | ID of the AWS Network Manager Global Network |