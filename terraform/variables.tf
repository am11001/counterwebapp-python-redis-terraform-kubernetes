variable "base_name" {
  default = "greetings"
}

variable "location" {
  default = "West Europe"
}

variable "tag-name" {
  default = "v2.0"
}

variable "ssh_public_key" {
  default = "./files/module9.pub"
}


variable "node_count" {
  default = 1
}

variable "vm_size" {
  default = "Standard_DS2_v2"
}

variable "node_pool1_name" {
  default = "frontendpool"
}

variable "node_pool2_name" {
  default = "backendpool"
}

