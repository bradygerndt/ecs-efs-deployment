resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 1
  min_capacity       = 0
  resource_id        = aws_ecs_service.factorio.id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "AWS/ECS"
}

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs-low-cpu" {
  alarm_name          = "ECS-LOW-CPU-UTILIZATION"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "900"
  statistic           = "Average"
  threshold           = 10

  alarm_description = "Monitor CPU usage of less than 10% on ecs resource"
  alarm_actions     = [aws_appautoscaling_policy.ecs_policy.arn]
}