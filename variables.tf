variable "global_network_description" {
  description = "Description of the global network"
  type        = string
  default     = "AWS Network Manager Global Network"
}

variable "core_network_description" {
  description = "Description of the core network"
  type        = string
  default     = "AWS Network Manager Core Network"
}

variable "use_custom_policy" {
  type        = bool
  description = "Set to true if you want to provide your own full policy document"
  default     = false
}

variable "segments" {
  type = list(object({
    name                           = string
    edge_locations                 = list(string)
    require_attachment_acceptance = optional(bool, false)
  }))
  description = "Segments and their associated edge locations"
}

variable "asn_ranges" {
  type = list(object({
    region    = string
    asn_range = string
  }))
  description = "ASN ranges for each region"
}


variable "edge_locations" {
    type = list(object({
        location = string
    }))
    description = "Edge locations"
}


variable "segment_actions" {
  type = list(object({
    action      = string
    segment     = string
    description = optional(string)
  }))
  description = "Defines behavior between segments (e.g., auto-accept)"
  default     = []
}

variable "attachment_policies" {
  type = list(object({
    rule_number     = number
    condition_logic = string
    conditions = list(object({
      type   = string               
      key    = string
      value  = string
      negate = optional(bool)
    }))
    action = object({
      association_method = string  
      segment            = string
    })
  }))
  description = "Attachment policies to control segment assignment based on rules"
  default     = []
}


variable "shared_segments" {
  type = list(object({
    name           = string
    share_with     = list(object({
      type  = string   
      value = string   
    }))
    permitted_actions = optional(list(string))
  }))
  description = "Shared segments and permissions"
  default     = []
}

variable "custom_policy_document" {
  type        = string
  description = "Custom policy document"
}




