resource "aws_launch_template" "test" {
  name_prefix   = "test"
  image_id      = "ami-0c802847a7dd848c0"
  instance_type = "t3a.nano"
  user_data = filebase64("app-launch.sh")
}
resource "aws_autoscaling_group" "test" {
  availability_zones        = ["ap-southeast-1a"]
  name                      = "test"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 180
  health_check_type         = "ELB"
  force_delete              = true
  termination_policies      = ["OldestInstance"]
  launch_template {
    id      = aws_launch_template.test.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.test.arn ]
  # vpc_zone_identifier = [aws_subnet.rajesh-vpc-pb-1a.id,aws_subnet.rajesh-vpc-pb-1b.id]
}
resource "aws_autoscaling_policy" "test" {
  name                   = "test"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.test.name
  scaling_adjustment     = 2
  cooldown               = 180
}

data "aws_subnet_ids" "test" {
  vpc_id = data.aws_vpc.main.id
}

data "aws_subnet" "test" {
  for_each = data.aws_subnet_ids.test.ids
  id       = each.value
}
resource "aws_lb" "test" {
  name               = "test"
  internal           = false
  load_balancer_type = "network"
  # subnets            = [for subnet in data.aws_subnet.test : subnet.id]
  subnets = [aws_subnet.rajesh-vpc-pb-1a.id,aws_subnet.rajesh-vpc-pb-1b.id]

}
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
resource "aws_lb_target_group" "test" {
  name     = "test"
  port     = 80
  protocol = "TCP"
  vpc_id   = data.aws_vpc.main.id
}
