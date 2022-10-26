provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "MyEc2" {
    ami = "ami-09d3b3274b6c5d4aa"
    instance_type = "t2.micro"
}

resource "aws_eip" "MyElasticeip" {
    instance = aws_instance.MyEc2.id
}

output "MyElasticeip" {
    value = aws_eip.MyElasticeip.public_ip
}

output "MyEc2" {
    value = aws_instance.MyEc2.id
}