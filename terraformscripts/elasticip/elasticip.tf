provider "aws" {
    region = "us-east-2"
    access_key = "AKIAWVHBCL6MXMJ4WKZD"
    secret_key = "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"
}

resource "aws_instance" "web" {
    ami = "ami-00399ec92321828f5"
    instance_type = "t2.micro"
    key_name = "vishn"
    tags = {
        Name = "Elasticip"
    }
}

resource "aws_eip" "lb" {
    instance = aws_instance.web.id
    vpc = true
    tags = {
        Name = "Elasticipaddress"
    }
}