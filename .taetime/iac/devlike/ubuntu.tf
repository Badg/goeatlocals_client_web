module "taetime_dev-base_ubuntu" {
    source = "../../../../taetime_dev/.taetime/iac/devlike/base_ubuntu_bionic"

    aws_control_acct_id = data.aws_caller_identity.control_plane.account_id
    host_workdir = var.host_workdir
    project_name = var.project_name
    project_data_volume = docker_volume.project_data.name
    container_name = "ubuntu"
    docker_host = var.docker_host
    container_network = docker_network.project_network.name
}
