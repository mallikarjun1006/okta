resource "okta_user" "test" {
	source  = "app.terraform.io/beyondid/okta/provider"
  version = "3.0.38"
  first_name = "TestAccterraform"
  last_name  = "Smith"
  login      = "test-acc-replace_with_uuidterraform@example.com"
  email      = "test-acc-replace_with_uuidterraform@example.com"
}
