# -"aws" provider is used by most resources in the main region
provider "aws" {
  region = var.main_region
}

# -"aws.recovery" provider is used by resources in the recovery region
provider "aws" {
  alias  = "recovery"
  region = var.recovery_region
}
