# DevOps Workflow using open-source tools (Linux, Github, Docker, CI/CD, Nomad, Monitoring).
![Run hello-test.py](https://github.com/Decnj/devops-intern-finale/actions/workflows/ci.yml/badge.svg)

- **Name:**  Nnamdi Declan Njemanze
- **Date:**  September 8th, 2025
- **Description:** This repository hosts my projects and includes a detailed overiew of various DevOps workflow tools.


## Linux & Scripting Basics
I created a directory "scripts" with a shell script "sysinfo.sh" that prints current user, current date, disk usage. I created variables and assigned values using the commands "whoami", "date", "df-h". The output was printed using "echo" command.

## Docker Basics
I ran a simple Flask web application inside a Docker container that prints the text "Hello DevOps!". The Docker container is built from an image I created using a Dockerfile with a lightweight base image "python:3.10-slim. In the Dockerfile, the working directory is set to "/app" and the "hello.py" script is copied from the "scripts" folder on my local machine to the container's working directory. The application is configured to listen on port 5000 inside the container. The Flask app is installed inside the container using "pip install flask" and the app starts automatically when a container runs from the image. The image is built locally using "docker build -t <image name> ." To make the content of the app accessible from the browser using "http://localhost:5000" I publish the port when running the container with "docker run --rm -p 5000:5000 <image name>".

## CI/CD with Github Actions
I setup a GitHub Actions workflow that automatically runs the python "hello.py" script whenever i push code to the main branch on my remote repo on github. I equally attached a live status  badge  that reflects the success or failure of each run.

## Job Deployment with Nomad
I wrote a configuration file "hello.nomad" for a Nomad job "flask-group". It sets up a Docker container using an image built locally and pushed to Docker Hub. The job operates within a group called "flask-group", it exposes the flask app on port 5000 of the node running the job. The task named "hello-task" is allocated minimal resources i.e. 100 MHz of CPU and 128 MB of memory. Before deployment of the job, start the Nomad agent in development mode "nomad agent -dev > ./nomad.log 2>&1 &". Once the agent is running, the job can be deployed using "nomad job run hello.nomad". Access the Flask App at: "http://localhost:5000"

## Monitoring with Grafana Loki
I started Loki locally using Docker with the follwing command, mounting my log directory from my host machine:
"docker run -d --name=loki -p 3100:3100 -v "$(pwd)/loki-config.yaml:/etc/loki/loki-config.yaml" grafana/loki:2.9.4 -config.file=/etc/loki/local-config.yaml"
To view the logs, I configured Grafana to connect to Loki at: "http://host.docker.internal:3100" and used Explore tab to query: "{job="nomad"}
This setup forwards logs from the mounted "/nomad/nomad.log" file to Loki and makes them visible in
Grafana.
