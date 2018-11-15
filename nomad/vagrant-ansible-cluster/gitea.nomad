job "gitea" {
  datacenters = ["dc1"]

  group "gitea" {
    count = 1

    ephemeral_disk {
      sticky  = true
      migrate = true
      size    = "2048"
    }

    task "server" {
      driver = "docker"

      config {
        image = "gitea/gitea:1.5"

        port_map = {
          http = 3000
          ssh = 22
        }

        volumes = [
          "local/gitea-data:/data"
        ]
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
        tags = ["traefik.enable=true"]
      }

      service {
        name = "gitea-ssh"
        port = "ssh"
        tags = ["traefik.enable=true"]
      }
    }
  }
}
