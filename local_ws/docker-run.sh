xhost +   # X 서버 접근 제어 해제

docker run -it \
    --device=/dev/dri \
    --group-add video \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --name=local \
    ksm/local-planner:v1
