
resource "aws_dynamodb_table" "todo_table" {
  name           = "todo-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }

  
  tags = {
    Name = "todo list app table"
  }
}
