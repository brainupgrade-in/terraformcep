variable "apps" {
  type = map(any)
  default = {
    "epsilion" = {
      "region" = "us-east-1",
    },
    "lambda" = {
      "region" = "us-east-2",
    },
    "omega" = {
      "region" = "us-west-1",
    },
    "sigma" = {
      "region" = "us-west-2",
    },
    "ext1" = {
      "region" = "ap-south-1",
    },
    "ext2" = {
      "region" = "ap-southeast-1",
    },
  }
}

resource "random_pet" "example" {
  for_each = var.apps
}

# Terraform console
# var.apps.sigma
# { for key, value in var.apps : key => value if value.region == "us-east-1" }
# cidrnetmask("172.16.0.0/12")