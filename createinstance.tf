resource "aws_key_pair" "levelup_key" {
key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Create AWS Instance
resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name      = aws_key_pair.levelup_key.key_name
  

  tags = {
    Name = "custom_instance"
  }
}


resource "docker_image" "backend" {
  name = "maven-application-assignment"

  build {
   path = "../."
   dockerfile = "Dockerfile"

  }

}

output "public_ip" {
  value = aws_instance.MyFirstInstnace.public_ip 
}
