resource "aws_dynamodb_table" "demo" {
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "productid"
  name             = "demo_backstage"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "productid"
    type = "S"
  }
}
