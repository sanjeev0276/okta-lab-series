# Okta IAM Lab Series - Identity & Access Management with Terraform

Hands-on implementation of Enterprise IAM architecture using Okta Identity Cloud and Terraform IaC. Part of OCP Cyber Security Portfolio.

**Author:** Sanjeev Shrestha  
**Location:** Allen, TX  
**Stack:** Okta (trial-5500832.okta.com), Terraform v1.x, Okta Provider v4.20.0, PowerShell

## Architecture Overview

![Lab 2 Architecture](02-okta-ad-integration/screenshots/architecture-diagram.png)

```
[On-Prem AD: IT OU, Finance OU, All Staff]
         |
         | AD Agent (Windows Server 2016+ member server)
         | Outbound HTTPS 443, polls Okta
         v
[Okta - trial-5500832.okta.com] <- Terraform creates groups here
         |
         v
[Cloud Apps via SSO]
```

## Labs Progress

### ✅ Lab 1 - Okta Tenant Setup
**Path:** `01-okta-tenant-setup/`
- Created Okta Developer Trial Tenant: `trial-5500832`
- Generated API Token for Terraform automation
- Configured `terraform.tfvars` and provider authentication
- `terraform init` + `terraform plan` validation
- Screenshots: tenant dashboard, API token creation

### ✅ Lab 2 - AD Integration (Current)
**Path:** `02-okta-ad-integration/`
**Objective:** Simulate AD sync to Okta via AD Agent architecture.

**Terraform Resources Created (via `terraform apply`):**
- `okta_group.ad_all_synced` - `AD-All-Staff-Synced` - ID: `00g18kodxkiGdCRbs698`
- `okta_group.ad_it_synced` - `AD-IT-Synced` - ID: `00g18koewc9cRxlzH698`
- `okta_group.ad_finance_synced` - `AD-Finance-Synced` - ID: `00g18kod1bjBtlSkR698`

**Key Learning:**
- AD Agent runs on Windows Server 2016+ member server, requires outbound HTTPS 443 to Okta, polls for changes, pushes to Domain Controller
- Terraform `main.tf` = blueprint (committed), `terraform.tfvars` = secret token (gitignored via `*.tfvars`), `terraform.tfstate` = state with real IDs (gitignored), `.terraform/` = provider plugins (gitignored)
- Groups verified in Okta Admin Portal: Directory > Groups > 9 groups including 3 synced (0 users expected - agent not installed, Terraform placeholder)

**Screenshots:**
- ![Terraform Plan](02-okta-ad-integration/screenshots/terraform-plan.png) - Plan: 3 to add
- ![Terraform Apply Success](02-okta-ad-integration/screenshots/terraform-apply-success.png) - Apply complete: 3 added
- ![Okta Portal Verification](02-okta-ad-integration/screenshots/okta-portal-groups-verified.png) - Verified in Portal: Directory > Groups


### ⏳ Lab 3 - SSO Integration (Next)
- SAML app integration
- Group-based assignments

## Security Practices
- `.gitignore` covers: `.terraform/`, `*.tfstate`, `*.tfstate.*`, `*.tfvars`, `api_token`
- API tokens rotated after exposure, never committed
- `terraform.tfvars` protected, verified via `git check-ignore`

## How to Run
```powershell
cd 02-okta-ad-integration/terraform
terraform init
terraform plan
terraform apply -auto-approve
```

## Terraform Files Explained
| File | Who Creates | Purpose | Commit? |
|------|-------------|---------|---------|
| main.tf | You | IaC blueprint | Yes |
| terraform.tfvars | You | Secret token | **Never** |
| .terraform.lock.hcl | Terraform | Version lock | Yes |
| terraform.tfstate | Terraform | Real IDs memory | **Never** |
| .terraform/ | Terraform | Plugins | **Never** |
