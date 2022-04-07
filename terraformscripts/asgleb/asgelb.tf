provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAWVHBCL6MXMJ4WKZD"
  secret_key = "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"
}

resource "aws_launch_configuration" "asg" {
  image_id      = "ami-00399ec92321828f5"
  name_prefix   = "Autoscaling"
  instance_type = "t2.micro"
  key_name      = "vishn"
}

resource "aws_autoscaling_group" "base" {
  availability_zones    = ["us-east-2a"]
  name                 = "autoscale"
  launch_configuration = "${aws_launch_configuration.asg.id}"
  max_size             = 4
  min_size             = 3
}

resource "aws_elb" "example" {
  name = "ElasticloadBalancer"
  availability_zones = ["us-east-2a"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}

resource "aws_elb_attachment" "sam" {
  elb      = aws_elb.example.id
  instance = "i-013b6de7e651c6d0a"
}