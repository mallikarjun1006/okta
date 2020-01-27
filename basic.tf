resource "okta_user" "test" {
  first_name = "TestAccterraform"
  last_name  = "Smith"
  login      = "test-acc-replace_with_uuidterraform@example.com"
  email      = "test-acc-replace_with_uuidterraform@example.com"
}
