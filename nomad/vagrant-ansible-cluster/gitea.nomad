job "gitea" {
  datacenters = ["dc1"]

  group "gitea" {
    count = 1
    task "server" {
      driver = "docker"

      config {
        image = "gitea/gitea"

        port_map = {
          http = 3000
          ssh = 22
        }
      }

      resources {
        network {
          port "http" {}
          port "ssh" {}
        }
      }

      service {
        name = "gitea"
        port = "http"
      }

      service {
        name = "gitea-ssh"
        port = "ssh"
        tags = ["traefik.enable=true"]
      }
    }
  }
}
