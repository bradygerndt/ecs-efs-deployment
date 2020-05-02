resource "aws_ecs_task_definition" "factorio" {
  family                = "factorio"
  container_definitions = file("task-definitions/factorio.json")

  volume {
    name      = "factorio-storage"
    host_path = "/ecs/factorio-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-2a, us-east-2b]"
  }
}