provider "aws" {
  shared_credentials_file = "/home/ec2-user/.aws/credentials"
  profile = "myprofile"
  region     = "${var.aws_region}"
}

provider "docker" {


}

data "aws_ecr_image" "service_image" {
  repository_name = "assignment2-citiustech"
  image_tag       = "latest"
}
