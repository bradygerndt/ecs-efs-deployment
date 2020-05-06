resource "aws_ecs_task_definition" "factorio" {
  family                = "factorio"
  container_definitions = file("task-definitions/factorio.json")
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512

  volume {
    name      = "factorio-storage"
    efs_volume_configuration {
        file_system_id = aws_efs_file_system.factorio-efs.id
        root_directory = "/factorio"
    }
  }
}
