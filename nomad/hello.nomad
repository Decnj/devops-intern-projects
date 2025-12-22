job "hello-devops" {
    datacenters = ["dc1"]
    type        = "service"

    group "flask" {
        count   = 1
	
	network {
	    port "http" {
	        static = 5000
	    }
	}

	task "flask-app" {
	    driver = "docker"

	    config {
	        image = "decnj/hello-flask"
		    ports = ["http"]
		}
		
		resources {
		    cpu    = 100  # Minimal MHz
		    memory = 256  # Minimal MB
		}
	}
    }
}
