#!/bin/bash
docker build -t docker-dcv . \
&& docker run -ti --mac-address="02:42:ac:11:00:02" --tmpfs /run --tmpfs /run/lock -p 8443:8443 --gpus all docker-dcv
