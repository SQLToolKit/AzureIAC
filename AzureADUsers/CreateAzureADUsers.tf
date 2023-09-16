
resource "azuread_user" "aduser1" {
  user_principal_name = "hsingh@karmjitocpoutlook.onmicrosoft.com"
  display_name        = "Harry"
  mail_nickname       = "Harry"
  password            = "Apple.121"
}

resource "azuread_user" "aduser2" {
  user_principal_name = "gsingh@karmjitocpoutlook.onmicrosoft.com"
  display_name        = "Garry"
  mail_nickname       = "Garry"
  password            = "Apple.121"
}

resource "azuread_user" "aduser3" {
  user_principal_name = "john@karmjitocpoutlook.onmicrosoft.com"
  display_name        = "john"
  mail_nickname       = "John"
  password            = "Apple.121"
}

resource "azuread_user" "aduser4" {
  user_principal_name = "kerry@karmjitocpoutlook.onmicrosoft.com"
  display_name        = "Kerry"
  mail_nickname       = "Kerry"
  password            = "Apple.121"
}