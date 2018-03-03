#!/bin/bash

docker build -t gateway .
docker run -d -it --name gateway -v build:/root/build gateway:latest
docker start -ai gateway