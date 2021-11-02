provider "aws" {
  profile = "myprofile"
  region     = "${var.aws_region}"
}

provider "docker" {


}

data "aws_ecr_image" "service_image" {
  repository_name = "assignment2-citiustech"
  image_tag       = "latest"
}
