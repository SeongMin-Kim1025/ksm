

#
cd docker-20.04_noetic
docker build -t ksm/ros-noetic:v1 .
cd ../

#
cd docker-local_planner
docker build -t ksm/local-planner:v1 .
cd ../


