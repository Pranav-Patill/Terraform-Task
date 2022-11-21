resource "aws_elb" "elb-prac" {
  name               = "elb-Prac"
  availability_zones = ["us-east-1a", "us-east-1b"]
  security_groups = [aws_security_group.elb-sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "elb-prac"
  }
}

# resource "aws_lb_target_group" "alb-example" {
#   health_check {
#     interval            = 10
#     path                = "/"
#     protocol            = "HTTP"
#     timeout             = "5"
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#   }
#   name        = "tf-example-lb-alb-tg"
#   target_type = "instance"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.main.id
# }

# resource "aws_lb" "prnv-alb" {
#   name               = "prnv-alb"
#   internal           = false
#   ip_address_type    = "ipv4"
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.elb-sg.id]
#   subnets = [aws_subnet.sub1.id,aws_subnet.sub2.id]
# }

# resource "aws_lb_listener" "alb-listener" {
#   load_balancer_arn = aws_lb.prnv-alb.arn
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb-example.arn
#   }
# }
# resource "aws_autoscaling_attachment" "terramino" {
#   autoscaling_group_name = aws_autoscaling_group.bar.id
#   alb_target_group_arn   = aws_lb_target_group.alb-example.arn
# }

# resource "aws_lb_target_group_attachment" "ec2_attach" {
#   count = length(aws_instance.prnv)
#   target_group_arn = aws_lb_target_group.alb-example.arn
#   target_id = aws_instance.prnv.id
# }