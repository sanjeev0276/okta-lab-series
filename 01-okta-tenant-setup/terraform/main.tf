# Lab 1: Kennon Technologies Tenant Setup

# Groups - Lab 1 requires these 4
resource "okta_group" "finance" {
  name        = "Finance"
  description = "Kennon Finance Team - Lab 1 - Managed by Terraform"
}

resource "okta_group" "it" {
  name        = "IT"
  description = "Kennon IT Team - Lab 1"
}

resource "okta_group" "hr" {
  name        = "HR"
  description = "Kennon HR Team - Lab 1"
}

resource "okta_group" "all_staff" {
  name        = "All-Staff"
  description = "All Kennon Employees"
}

# Users - Kennon employees (Lab 1 spec)
resource "okta_user" "john_smith" {
  first_name = "John"
  last_name  = "Smith"
  login      = "johnsmith@gmail.com"
  email      = "sanjeev0276+johnsmith@gmail.com"
  title      = "CFO"
  department = "Finance"
  password   = "Lab1Temp123!"   # <- ADD THIS
}

resource "okta_user" "jane_doe" {
  first_name = "Jane"
  last_name  = "Doe"
  login      = "janedoe@gmail.com"
  email      = "sanjeev0276+janedoe@gmail.com"
  title      = "IT Manager"
  department = "IT"
  password   = "Lab1Temp123!"   # <- ADD THIS
}

resource "okta_user" "bob_johnson" {
  first_name = "Bob"
  last_name  = "Johnson"
  login      = "bobjohnson@gmail.com"
  email      = "sanjeev0276+bobjohnson@gmail.com"
  title      = "HR Manager"
  department = "HR"
  # Bob already ACTIVE, don't set password again or it will reset
}
# Group Memberships
resource "okta_group_memberships" "finance_members" {
  group_id = okta_group.finance.id
  users = [okta_user.john_smith.id]
}

resource "okta_group_memberships" "it_members" {
  group_id = okta_group.it.id
  users = [okta_user.jane_doe.id]
}

resource "okta_group_memberships" "hr_members" {
  group_id = okta_group.hr.id
  users = [okta_user.bob_johnson.id]
}

resource "okta_group_memberships" "all_staff_members" {
  group_id = okta_group.all_staff.id
  users = [
    okta_user.john_smith.id,
    okta_user.jane_doe.id,
    okta_user.bob_johnson.id
  ]
}