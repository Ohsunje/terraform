provider  "aws" {
  region = "ap-northeast-2" 
}

resource "aws_security_group" "instance" {
 name = "terraform-example-instance"
 ingress {
 from_port = var.server_port
 to_port = var.server_port
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "example" {
  ami           = "ami-09a7535106fbd42d5" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data =<<-EOF
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p 8080 &
EOF

  user_data_replace_on_change = true
  tags  =  {
    Name  =  "terraform-example"
  } 
}

variable "server_port" {
 description = "The port. the server will use for HTTP requests"
 type = number
}

output "webip" {
  value = aws_instance.example.public_ip
}
