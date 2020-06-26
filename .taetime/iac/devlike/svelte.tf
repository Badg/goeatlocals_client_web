module "taetime_dev-base_svelte" {
    source = "../../../../taetime_dev/.taetime/iac/devlike/base_svelte"

    aws_control_acct_id = data.aws_caller_identity.control_plane.account_id
    host_workdir = var.host_workdir
    project_name = var.project_name
    container_name = "svelte"
    docker_host = var.docker_host
    container_network = docker_network.project_network.name
    project_data_volume = docker_volume.project_data.name
}
