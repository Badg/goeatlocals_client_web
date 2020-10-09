# TODO: wire up "tae devops packer" so that it automatically populates these
# instead of defining them here as defaults
variable "project_name" {
    type = string
    description = "The name of the project, as used by taetime"
    default = "goeatlocals_client_web"
}

variable "image_name" {
    type = string
    description = "The name of the image within the project"
    default = "tileserver_trex"
}

variable "aws_acct_id" {
    type = string
    description = "The AWS account ID for the control plane"
}

variable "base_image_date" {
    type = string
    description = "The date tag to use for the base image."
    default = "2020-05-17"
}


source "docker" "bionic" {
    image = "${var.aws_acct_id}.dkr.ecr.us-west-2.amazonaws.com/taetime_dev/base_ubuntu_bionic:${var.base_image_date}"
    commit = true
    ecr_login = true
    aws_profile = "taev_root_devops"
    login_server = "https://${var.aws_acct_id}.dkr.ecr.us-west-2.amazonaws.com/"
}

build {
    sources = [
        "source.docker.bionic"
    ]

    provisioner "shell" {
        inline = [
            # TODO: remove these apts; need to update base image first
            "apt-get update",
            "apt-get upgrade -y",
            "apt-get install -y libgdal20",
            "curl -O -L https://github.com/t-rex-tileserver/t-rex/releases/download/v0.10.1/t-rex-v0.10.1-x86_64-unknown-linux-gnu.deb && dpkg -i t-rex-v0.10.1-x86_64-unknown-linux-gnu.deb && rm t-rex-v0.10.1-x86_64-unknown-linux-gnu.deb"
        ]
    }

    # ------------------------------------------------------------------------
    # Don't touch these for normal use! This will automatically adhere to our
    # naming conventions based on the variables.
    post-processor "docker-tag" {
        repository = "${var.aws_acct_id}.dkr.ecr.us-west-2.amazonaws.com/${var.project_name}/${var.image_name}"
        tag = [formatdate("YYYY-MM-DD", timestamp())]
    }

    post-processor "docker-push" {
        ecr_login = true
        aws_profile = "taev_root_devops"
        login_server = "https://${var.aws_acct_id}.dkr.ecr.us-west-2.amazonaws.com/"
    }
}
