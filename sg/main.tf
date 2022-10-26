provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "MyEc2" {
    ami = "ami-09d3b3274b6c5d4aa"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.Mywebtraffic.name]
}

resource "aws_security_group" "Mywebtraffic" {
    name = "Allow HTTPS"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "Mywebtraffic-SG" {
    value = aws_security_group.Mywebtraffic.arn
}

output "MyEc2" {
    value = aws_instance.MyEc2.id
}