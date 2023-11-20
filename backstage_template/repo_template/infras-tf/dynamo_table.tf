resource "aws_dynamodb_table" "demo" {
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = var.dynamodb_partition_key
  name             = var.dynamodb_table_name
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = var.dynamodb_partition_key
    type = "S"
  }
}
