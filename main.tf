resource "aws_autoscaling_group" "hatest" {
  #name                      = "${aws_launch_configuration.hatest.name}-asg"
  #name                      = var.repave_strategy == "bluegreen" ? "${var.aws_launch_configuration_name}-asg" : "rolling-asg-${var.app_color}"
  #name                      = "asg-${var.app_color}"
  name                      = var.repave_strategy == "bluegreen" ? "${var.aws_launch_configuration_name}-asg" : "rolling-asg"
  vpc_zone_identifier       = var.aws_subnet_ids
  launch_configuration      = var.aws_launch_configuration_name
  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [var.aws_elb_name]
  force_delete              = true

  tag {
    key                 = "environment"
    value               = var.app_env
    propagate_at_launch = true
  }

  tag {
    key                 = "appname"
    value               = var.app_name
    propagate_at_launch = true
  }

  tag {
    key                 = "csiappid"
    value               = var.app_csi
    propagate_at_launch = true
  }

  #tag {
  #  key                 = "appcolor"
  #  value               = var.app_color
  #  propagate_at_launch = true
  #}

}

  