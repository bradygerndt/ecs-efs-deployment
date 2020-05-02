resource "aws_ecs_service" "factorio" {
  name            = "factorio"
  cluster         = "aws_ecs_cluster.factorio.id"
  task_definition = "aws_ecs_task_definition.factorio.arn"
  desired_count   = 1

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}