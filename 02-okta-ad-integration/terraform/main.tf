# Lab 2: Okta AD Integration - Simulated
terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    }
  }
}

provider "okta" {
  org_name  = var.okta_org_name
  base_url  = "okta.com"
  api_token = var.okta_api_token
}

variable "okta_org_name" {
  type = string
}

variable "okta_api_token" {
  type      = string
  sensitive = true
}

resource "okta_group" "ad_finance_synced" {
  name        = "AD-Finance-Synced"
  description = "Lab 2 - Synced from AD via Okta AD Agent - Finance OU - Managed by Terraform"
}

resource "okta_group" "ad_it_synced" {
  name        = "AD-IT-Synced"
  description = "Lab 2 - Synced from AD via Okta AD Agent - IT OU - Managed by Terraform"
}

resource "okta_group" "ad_all_synced" {
  name        = "AD-All-Staff-Synced"
  description = "Lab 2 - All users synced from AD Domain Controller via agent"
}

output "lab2_architecture_note" {
  value = "AD Agent on Windows Server 2016+ member server, outbound HTTPS 443 to Okta, polls for provisioning to DC"
}
