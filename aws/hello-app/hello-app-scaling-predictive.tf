resource "aws_launch_template" "test" {
  name_prefix   = "test"
  image_id      = "ami-0cc8dc7a69cd8b547"
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
}
resource "aws_autoscaling_policy" "test" {
  name                   = "test"
  autoscaling_group_name = aws_autoscaling_group.test.name
  policy_type            = "PredictiveScaling"
  predictive_scaling_configuration {
    metric_specification {
      target_value = 10
      customized_load_metric_specification {
        metric_data_queries {
          id         = "load_sum"
          expression = "SUM(SEARCH('{AWS/EC2,AutoScalingGroupName} MetricName=\"CPUUtilization\" test', 'Sum', 3600))"
        }
      }
      customized_scaling_metric_specification {
        metric_data_queries {
          id = "scaling"
          metric_stat {
            metric {
              metric_name = "CPUUtilization"
              namespace   = "AWS/EC2"
              dimensions {
                name  = "AutoScalingGroupName"
                value = "test"
              }
            }
            stat = "Average"
          }
        }
      }
      customized_capacity_metric_specification {
        metric_data_queries {
          id          = "capacity_sum"
          expression  = "SUM(SEARCH('{AWS/AutoScaling,AutoScalingGroupName} MetricName=\"GroupInServiceIntances\" test', 'Average', 300))"
          return_data = false
        }
        metric_data_queries {
          id          = "load_sum"
          expression  = "SUM(SEARCH('{AWS/EC2,AutoScalingGroupName} MetricName=\"CPUUtilization\" test', 'Sum', 300))"
          return_data = false
        }
        metric_data_queries {
          id         = "weighted_average"
          expression = "load_sum / capacity_sum"
        }
      }
    }
  }
}
data "aws_vpc" "main"{
    id="vpc-0fa1dcbf4951c2e69"
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
  subnets            = [for subnet in data.aws_subnet.test : subnet.id]

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
