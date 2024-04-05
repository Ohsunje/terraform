provider  "aws" {
  region = "ap-northeast-2" 
}

resource "aws_instance" "example" {
  ami           = "ami-09a7535106fbd42d5" 
  instance_type = "t2.micro"
  tags  =  {
    Name  =  "terraform-example"
  } 
}

