variable "function_name" {}

variable "handler" {
  default     = "main.lambda_handler"    
}

variable "runtime" {
  default     = "python3.10"
}

variable "subnet_ids" {
    default = ["subnet-0fd0389467e854d58","subnet-0c5a552da99449eee", "subnet-0a88054dd4eb10909"]
}

variable "security_group_ids" {
    default = ["sg-0cc4c5c91bcdc307b"]
}

variable "description" {}

variable "compatible_runtimes" {
  type        = list(string)
  description = "Runtime"
  default     = ["python3.10"]
}
variable "api_gate_way_name" {}

variable "statefile_name" {}

variable "dynamodb_partition_key" {}

variable "dynamodb_table_name" {}