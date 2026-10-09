terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    }
  }
}

provider "okta" {
  org_name  = "trial-5500832"  # YOUR org
  base_url  = "okta.com"
  api_token = var.okta_api_token  # will prompt, not stored in git
}

variable "okta_api_token" {
  description = "Okta API Token - create at Security > API > Tokens"
  type        = string
  sensitive   = true
}