provider "okta" {
  org_name  = "dev-636187"
  base_url  = "oktapreview.com"
  api_token = "00cH31U7QcJB2k_dpsP8KVktyHD99z8uxt4GTg8chK"
}

resource okta_user test21 {
  first_name = "TestAcc2"
  last_name  = "Jones2"
  login      = "john_replace_with_uuid21@ledzeppelin.com"
  email      = "john_replace_with_uuid21@ledzeppelin.com"
}

resource okta_user test11 {
  first_name = "TestAcc11"
  last_name  = "Jones11"
  login      = "john_replace_with_uuid11@ledzeppelin.com"
  email      = "john_replace_with_uuid11@ledzeppelin.com"
}

resource okta_user test121 {
  first_name = "TestAcc121"
  last_name  = "Jones121"
  login      = "john_replace_with_uuid121@ledzeppelin.com"
  email      = "john_replace_with_uuid121@ledzeppelin.com"
}
