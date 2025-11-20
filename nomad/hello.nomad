job "flask-hello" {
  datacenters = ["dc1"]
  type	      = "service"

  group "flask-group" {
    count = 1
    
    network {
      port "web" {
        static = 5000
      }
    }
  
    service {
      name = "flask-hello"
      port = "web"
      
      check {
        type      = "http"
	path      = "/"
	interval  = "10s"
	timeout   = "2s"
      }
    }

      task "hello-task" {
        driver = "docker"

        config {
          image = "decnj/hello-flask:latest"
          ports = ["web"]
        }

        resources {
	  cpu    = 100 # Hz
  	  memory = 128 # MB
	}
      }
  }
}
