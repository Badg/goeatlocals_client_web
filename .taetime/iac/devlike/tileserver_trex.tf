locals {
    # TODO: oops, this doesn't scale lol
    trex_container_name = "tileserver_trex"
}

variable "tileserver_trex_base_image_date" {
    type = string
    description = "The date tag to use for the tileserver_trex base image."
    default = "2020-06-09"
}

resource "docker_container" "goeatlocals_client_web-tileserver_trex" {
    image = docker_image.goeatlocals_client_web-tileserver_trex.latest
    name  = "${var.project_name}-${local.trex_container_name}"

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
        "LC_ALL=C.UTF-8",
        # I don't want to explicitly specify this, but it works as a workaround
        # for a terraform docker provider bug that was resulting in always
        # forcing replacement of resources
        "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    ]

    entrypoint = [ "/bin/bash", "/project_src/.taetime/iac/devlike/tileserver_trex_shim.sh" ]

    ports {
        internal = 6767
    }
}

data "docker_registry_image" "goeatlocals_client_web-tileserver_trex" {
    name = "${local.aws_control_acct_id}.dkr.ecr.us-west-2.amazonaws.com/goeatlocals_client_web/tileserver_trex:${var.tileserver_trex_base_image_date}"
}

resource "docker_image" "goeatlocals_client_web-tileserver_trex" {
    name          = data.docker_registry_image.goeatlocals_client_web-tileserver_trex.name
    pull_triggers = [data.docker_registry_image.goeatlocals_client_web-tileserver_trex.sha256_digest]
}
