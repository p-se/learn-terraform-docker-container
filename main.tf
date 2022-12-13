terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create a container
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8080
  }
}
