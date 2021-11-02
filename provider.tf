provider "aws" {
  profile = "myprofile"
  region     = "${var.aws_region}"
}

provider "docker" {


}
