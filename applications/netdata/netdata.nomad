job "netdata" {
  region = "us-east-2"
  datacenters = ["dc1"]
  type = "service"

  group "netdata-app" {
    count = "1"
    task "server" {
      driver = "docker"

      config {
        image = "pmarchi/terraform-nomad-consul-traefik"
        port_map {
            http = 19999
        }
      }

      resources {
        network {
          mbits = 1
          port "http" {
            static = "19999"
          }
        }
      }

      service {
        name = "netdata-check"
        port = "http"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}