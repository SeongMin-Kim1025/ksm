

#
cd docker-20.04_noetic
docker build -t ksm/ros-noetic:v1 .
cd ../

#
cd docker-local_planner
docker build -t ksm/local-planner:v1
cd ../

#
docker run -it \
    --rm -p 11345:11345 \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --name=bbb \
    ksm/local-planner:v1
