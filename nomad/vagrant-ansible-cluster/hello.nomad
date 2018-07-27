job "hello-world" {
  datacenters = ["dc1"]

  group "example" {
    count = 3
    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo"
        args = [
          "-listen", ":8080",
          "-text", "hello world",
        ]

        port_map = {
          http = 8080
        }
      }

      resources {
        network {
          port "http" {}
        }
      }

      service {
        name = "hello-world"
        port = "http"
        tags = ["traefik.enable=true"]
      }
    }
  }
}
