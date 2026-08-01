variable "yandex_token" {
    type        = string
    description = "Yandex Cloud OAuth token"
    sensitive   = true # конфедециальные данные
}

variable "yandex_cloud_id" {
  type          = string
  description   = "Yandex Cloud ID"
}

variable "yandex_folder_id" {
  type          = string
  description   = "Yandex Folder ID"
}

variable "def_ssh_public_key" {
  type = string
  default = "~/.ssh/yc.pub"
}

variable "def_numbers_of_cores" {
  type = number
  default = 2
}

variable "def_ram_size" {
  type = number
  default = 4
}