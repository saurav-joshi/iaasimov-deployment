#! /bin/bash
# start portainer
RES=$(docker ps -a | grep portainer | grep up)

if [ -n "$RES" ]; then
  echo "Portainer not running"
  docker run -d -p 9000:9000 --restart always --name iaasimov-portainer -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer
fi

# load the GROK docker image and run
echo "Loading iaasimov-GROK"
docker load -i /home/opc/iaasimov-grok-latest.tar.gz

# Stop the container and remove, then start the new image
docker stop iaasimov-grok
docker rm iaasimov-grok
docker run -d -p 8080:8080 --name iaasimov-grok iaasimov-grok
# docker run -d -p 8080:8080 --restart always --name iaasimov-grok iaasimov-grok