#!/bin/bash

#1
docker build -t ksm/local-planner:v1

#2
docker run -it \
    --rm -p 11345:11345 \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --name=bbb \
    ksm/local-planner:v1
