#! /bin/bash

# Stop the container and remove, then start the new image
mkdir -p /iaasimov/GROK
cd /iaasimov/GROK/iaasimov-docker
/usr/local/bin/docker-compose down
cd ..
rm -rf /iaasimov/GROK
mkdir -p GROK
unzip /home/opc/iaasimov-dockercompose.zip -d /iaasimov/GROK

cd /iaasimov/GROK/iaasimov-docker
/usr/local/bin/docker-compose build
/usr/local/bin/docker-compose up -d

