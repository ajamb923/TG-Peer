# Below is the provider which helps in connecting with AWS Account
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias   = "other_region"
  region  = "us-east-2"
  profile = "other_region"
}
