variable "alb_listen_ports" {
    type = map(any)
    default = { 
        http = 80
        https = 443
  }
}

variable "project_name" {
    type = string
    default = "demo-backstage"
}

variable "backstage_image_url" {
  type = string
  default = "204173949765.dkr.ecr.ap-southeast-2.amazonaws.com/demo-backstage"
}

variable "backstage_image_tag" {
  type = string
  default = "1.0.0"
}
