resource "aws_db_instance" "db_pranav" {
  allocated_storage = 20
  identifier = "rds-terraform"
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "8.0.27"
  instance_class = "db.t2.micro"
  name = "db_pranav"
  username = "pranav"
  password = "12345678"
  publicly_accessible    = true
  skip_final_snapshot    = true

    tags = {
      Name = "RDB-prnv"
    }
}
