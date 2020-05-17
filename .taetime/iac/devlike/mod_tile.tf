locals {
    aws_control_acct_id = data.aws_caller_identity.control_plane.account_id
    container_name = "mod_tile"
    project_data_volume = docker_volume.project_data.name
    container_network = docker_network.project_network.name
}

variable "mod_tile_base_image_date" {
    type = string
    description = "The date tag to use for the mod_tile base image."
    default = "2020-05-17"
}

resource "docker_container" "goeatlocals_client_web-mod_tile" {
    image = docker_image.goeatlocals_client_web-mod_tile.latest
    name  = "${var.project_name}-${local.container_name}"

    networks_advanced { name = local.container_network }
    volumes {
        container_path = "/taetime_dev"
        host_path = "${var.host_workdir}/taetime_dev"
    }
    volumes {
        container_path = "/project_src"
        host_path = "${var.host_workdir}/${var.project_name}"
    }
    volumes {
        container_path = "/project_data"
        volume_name = local.project_data_volume
    }

    env = [
        "LC_ALL=C.UTF-8"
    ]

    entrypoint = [ "/bin/bash", "/project_src/.taetime/iac/devlike/mod_tile_shim.sh" ]

    ports {
        internal = 80
    }
}

data "docker_registry_image" "goeatlocals_client_web-mod_tile" {
    name = "${local.aws_control_acct_id}.dkr.ecr.us-west-2.amazonaws.com/goeatlocals_client_web/mod_tile:${var.mod_tile_base_image_date}"
}

resource "docker_image" "goeatlocals_client_web-mod_tile" {
    name          = data.docker_registry_image.goeatlocals_client_web-mod_tile.name
    pull_triggers = [data.docker_registry_image.goeatlocals_client_web-mod_tile.sha256_digest]
}
