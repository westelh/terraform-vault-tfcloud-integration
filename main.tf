resource "vault_jwt_auth_backend" "tfcloud" {
  description = "Endpoint for dynamic creds of tfcloud"
  path = var.auth_path
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer  = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "role" {
  for_each = var.workspaces
  backend = vault_jwt_auth_backend.tfcloud.path
  role_name = "${each.value.organization}-${each.value.project}-${each.value.workspace}"
  role_type = "jwt"
  token_policies = each.value.policies
  user_claim = "terraform_full_workspace"
  bound_claims = {
    sub = "organization:${each.value.organization}:project:${each.value.project}:workspace:${each.value.workspace}:run_phase:*"
  }
  bound_audiences = ["vault.workload.identity"]
  bound_claims_type = "glob"
}

