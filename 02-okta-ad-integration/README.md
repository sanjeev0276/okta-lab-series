# Lab 2 - AD Integration via Terraform

**Objective:** Simulate AD → Okta sync using AD Agent architecture.

**Terraform:** Created 3 Okta groups via `terraform apply`.

## Architecture
```
[On-Prem AD: IT OU, Finance OU, All Staff]
         |
         | AD Agent - Windows Server 2016+ member server
         | Outbound HTTPS 443, polls Okta
         v
[Okta - trial-5500832.okta.com] <- Groups created here
         |
         v
[Cloud Apps via SSO]
```

## Resources Created
- `AD-All-Staff-Synced` - `00g18kodxkiGdCRbs698`
- `AD-IT-Synced` - `00g18koewc9cRxlzH698`
- `AD-Finance-Synced` - `00g18kod1bjBtlSkR698`

## Evidence (Screenshots in this folder)

1. **terraform-plan.png** - Plan: 3 to add
2. **terraform-apply-success.png** - Apply complete: 3 added
3. **okta-portal-groups-verified.png** - Verified in Portal: Directory > Groups
4. **architecture-diagram.png** - Lab 2 architecture

## How to Run
```powershell
cd terraform
terraform init
terraform plan
terraform apply
```

## Key Learning
- AD Agent runs on member server, outbound 443 only
- `main.tf` = blueprint (commit YES), `terraform.tfvars` = secret (NEVER), `terraform.tfstate` = IDs memory (NEVER)