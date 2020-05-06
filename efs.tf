resource "aws_efs_file_system" "factorio-efs" {
  tags = {
    Name = "factorio-EFS"
  }
}

resource "aws_efs_mount_target" "mount" {
  file_system_id = aws_efs_file_system.factorio-efs.id
  subnet_id      = aws_subnet.main.id
  security_groups = [aws_security_group.allow_efs_mount.id]
}