job "nginx" {
  datacenters = ["dc1"]
  type = "service"
  group "cache" {
    count = 1
    task "redis" {
      driver = "docker"
      config {
        image = "nginx:1.11.10"
        volumes = ["new/default.conf:/etc/nginx/conf.d/default.conf" ]
        network_mode = "host"
      }

      artifact {
        source = "https://gist.githubusercontent.com/dadgar/2dcf68ab5c49f7a36dcfe74171ca7936/raw/c287c16dbc9ddc16b18fa5c65a37ff25d2e0e667/nginx.conf"
      }

      template {
        source        = "local/nginx.conf"
        destination   = "new/default.conf"
        change_mode   = "restart"
      }

      resources {
        network {
          mbits = 10
          port "nginx" {
            static = 8080
          }
        }
      }
    }
  }
}