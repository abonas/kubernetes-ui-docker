# kubernetes-ui-docker

...a really simple Docker container for playing around with the Kubernetes WebUI. Based on the excellent Docker-noobie friendly [phusion/baseimage](https://github.com/phusion/baseimage-docker).


**Note:** Do not use this for anything resembling a production environment.

## Usage

First, verify it works:

    # docker build -t kubernetes-ui .
    # docker run -t -p 8001 kubernetes-ui

This will expose port 8001 within the container, you should run `docker ps` to check the port equivalent on the host machine and go to http://localhost:{EXPOSED_PORT} to confirm you get the Kubernetes Dashboard.

nginx is pointed to `/mnt/kubernetes-ui` which is by default set up to serve the WebUI located within the repository.
