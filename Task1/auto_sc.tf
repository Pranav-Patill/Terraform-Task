resource "aws_launch_template" "as_temp" {
  name_prefix   = "as_temp"
  image_id      = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a","us-east-1b"]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1
  health_check_type = "EC2"
  health_check_grace_period = 100
  load_balancers = [aws_elb.elb-prac.name]
  # vpc_zone_identifier = [aws_subnet.sub1.id,aws_subnet.sub2.id]

  launch_template {
    id      = aws_launch_template.as_temp.id
    version = "$Latest"
  }
}