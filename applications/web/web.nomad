job "web" {
  # Specify the region and datacenters this job can run in.
  region = "us-east-2"
  datacenters = ["dc1"]

  # Service type jobs optimize for long-lived services. This is
  # the default but we can change to batch for short-lived tasks.
  # type = "service"

  # Priority controls our access to resources and scheduling priority.
  # This can be 1 to 100, inclusively, and defaults to 50.
  # priority = 50

  # Restrict our job to only linux. We can specify multiple
  # constraints as needed.
  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  # Configure the job to do rolling updates
  update {
    # Stagger updates every 10 seconds
    stagger = "10s"

    # Update a single task at a time
    max_parallel = 1
  }

  # Create a 'nginx' group. Each task in the group will be
  # scheduled onto the same machine.
  group "nginx" {
    # Control the number of instances of this groups.
    # Defaults to 1
    # count = 1

    # Restart Policy - This block defines the restart policy for TaskGroups,
    # the attempts value defines the number of restarts Nomad will do if Tasks
    # in this TaskGroup fails in a rolling window of interval duration
    # The delay value makes Nomad wait for that duration to restart after a Task
    # fails or crashes.
    restart {
      interval = "5m"
      attempts = 10
      delay    = "25s"
      mode     = "delay"
    }

    # Define a nginx task to run
    task "nginx" {
      # Use Docker to run the task.
      driver = "docker"

      # Configure Docker driver with the image
      config {
        image        = "hashidemo/nginx:latest"
        network_mode = "host"
      }

      service {
        name = "nginx"
        tags = ["global"]
        port = "http"

        check {
          name     = "nginx alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }

      # We must specify the resources required for
      # this task to ensure it runs on a machine with
      # enough capacity.
      resources {
        cpu = 500 # Mhz
        memory = 256 # MB

        network {
          mbits = 1

          # Request for a static port
          port "http" {
            static = 80
          }
        }
      }
    }
  }

  # Create a 'nodejs' group. Each task in the group will be
  # scheduled onto the same machine.
  group "nodejs" {
    # Control the number of instances of this groups.
    # Defaults to 1
    count = 3

    # Restart Policy - This block defines the restart policy for TaskGroups,
    # the attempts value defines the number of restarts Nomad will do if Tasks
    # in this TaskGroup fails in a rolling window of interval duration
    # The delay value makes Nomad wait for that duration to restart after a Task
    # fails or crashes.
    restart {
      interval = "5m"
      attempts = 10
      delay    = "25s"
      mode     = "delay"
    }

    # Define a nodejs task to run
    task "nodejs" {
      # Use Docker to run the task.
      driver = "docker"

      # Configure Docker driver with the image
      config {
        image        = "hashidemo/nodejs:latest"
        network_mode = "host"
      }

      service {
        name = "nodejs"
        tags = ["global"]
        port = "http"

        check {
          name     = "nodejs alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }

        check {
          name     = "nodejs running on port 8080"
          type     = "http"
          protocol = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      # We must specify the resources required for
      # this task to ensure it runs on a machine with
      # enough capacity.
      resources {
        cpu = 500 # Mhz
        memory = 256 # MB

        network {
          mbits = 1

          # Request for a dynamic port
          port "http" {
          }
        }
      }
    }
  }
}