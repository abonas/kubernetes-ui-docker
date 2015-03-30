# kubernetes-ui-docker

...a really simple Docker container for playing around with the Kubernetes WebUI. Based on the excellent Docker-noobie friendly [phusion/baseimage](https://github.com/phusion/baseimage-docker).


**Note:** Do not use this for anything resembling a production environment.

## Usage

First, verify it works:

    # docker build -t kubernetes-ui .
    # docker run -t -p 8001 kubernetes-ui

This will expose port 8001 within the container, you should run `docker ps` to check the port equivalent on the host machine and go to http://localhost:{EXPOSED_PORT} to confirm you get the Kubernetes Dashboard.

nginx is pointed to `/mnt/kubernetes-ui` which is by default set up to serve the WebUI located within the repository.

For pass the correct settings:
```
docker run \
-e ENV_K8S_API_SERVER="https://admin:jxsffWYgwABFCBXG@104.154.65.114/api/v1beta2" \
-e ENV_K8S_DATA_SERVER="http://104.154.38.73:5555/cluster" \
-e ENV_K8S_DATA_POLL_MIN_INTERVAL_SEC=10 \
-e ENV_K8S_DATA_POLL_MAX_INTERVAL_SEC=120 \
-e ENV_K8S_DATA_POLL_ERROR_THRESHOLD=5 \
-e ENV_C_ADVISOR_PROXY="http://104.154.65.114:9090/proxy?TARGET=" \
-e ENV_C_ADVISOR_PORT=4194 \
-t -p 8001:80 kubernetes-ui
```
