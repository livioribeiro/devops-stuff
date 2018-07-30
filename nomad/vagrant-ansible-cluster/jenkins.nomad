job "jenkins" {
  datacenters = ["dc1"]

  group "jenkins" {
    count = 1

    ephemeral_disk {
      sticky  = true
      migrate = true
      size    = "4096"
    }

    task "server" {
      driver = "docker"

      config {
        image = "jenkins/jenkins:lts"

        port_map = {
          http = 8080
          jnlp = 50000
        }
      }

      resources {
        cpu = 1000
        memory = 512
        network {
          port "http" {}
          port "jnlp" {}
        }
      }

      service {
        name = "jenkins"
        port = "http"
        tags = ["traefik.enable=true"]
      }

      service {
        name = "jenkins-jnlp"
        port = "jnlp"
      }
    }
  }
}
