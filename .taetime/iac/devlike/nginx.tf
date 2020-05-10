module "taetime_dev-base_nginx" {
    source = "../../../../taetime_dev/.taetime/iac/devlike/base_nginx"

    aws_control_acct_id = data.aws_caller_identity.control_plane.account_id
    host_workdir = var.host_workdir
    project_name = var.project_name
    container_name = "nginx"
    docker_host = var.docker_host
    container_network = docker_network.project_network.name
}
