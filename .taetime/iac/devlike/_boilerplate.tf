# TODO: should the providers be symlinked in or something? it seems silly to
# need this boilerplate on literally everything
terraform {
    backend "local" {}
}

provider "aws" {
    alias = "control_plane"
    region = "us-west-2"
    profile = "taev_developer"
    version = "~> 2.58"
}
data "aws_caller_identity" "control_plane" {
    provider = aws.control_plane
}

provider "docker" {
    version = "~> 2.7"
    host = var.docker_host

    registry_auth {
        # TODO: source this value using data from actual aws account
        address = "https://${data.aws_caller_identity.control_plane.account_id}.dkr.ecr.us-west-2.amazonaws.com"
        username = var.ecr_username
        password = var.ecr_password
    }
}

resource "docker_network" "project_network" {
    name = "${var.project_name}-network"
}

resource "docker_volume" "project_data" {
    name = "${var.project_name}-data"
}
