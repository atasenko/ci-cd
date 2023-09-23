resource "local_file" "ansible_prod_hosts" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      sonarqube = yandex_compute_instance.sonarqube.*,
      nexus     = yandex_compute_instance.nexus.*
    }
  )

  filename = "${path.module}./infrastructure/inventory/cicd/hosts.yml"
}
