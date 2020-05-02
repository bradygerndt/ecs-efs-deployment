resource "aws_ecs_service" "factorio" {
  name            = "factorio"
  cluster         = "aws_ecs_cluster.factorio-cluster.id"
  task_definition = "aws_ecs_task_definition.factorio.arn"
  desired_count   = 1

  network_configuration {

    subnets          = [aws_subnet.main.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.allow_factorio.id]
  }
}
