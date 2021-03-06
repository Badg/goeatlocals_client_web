variable "ecr_username" {
    type = string
    description = "Your ECR username -- generated by the ECR login server??"
}

variable "ecr_password" {
    type = string
    description = "Your ECR password -- generated by the ECR login server"
}

variable "host_workdir" {
    type = string
    description = "The path on the host to the work directory"
}

variable "project_name" {
    type = string
    description = "The name of the project, as used by taetime"
}

variable "docker_host" {
  type = string
  # Just defaulting to windows for now; this needs to be different on other
  # platforms
  default = "npipe:////./pipe/docker_engine"
  # for OSX: "unix:///var/run/docker.sock"
}
