# Stage 1: Base Image with ROS and Avoidance Module
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# Install essential tools
RUN apt-get update && apt-get install -y curl

# Add ROS repository and install ROS Noetic with Gazebo
RUN apt-get update && \
    apt-get install -y lsb-release && \
    apt-get install -y gnupg gnupg2 gnupg1 && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt update && \
    apt install -y ros-noetic-desktop-full && \
    echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc && \
    /bin/bash -c "source /opt/ros/noetic/setup.bash"
    
RUN apt install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control


# Install ROS dependencies and Catkin tools
RUN apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential && \
    rosdep init && \
    rosdep update && \
    apt install -y python3-catkin-tools

# Install MAVROS and Geographiclib dataset
RUN apt-get install -y ros-noetic-mavros ros-noetic-mavros-extras \
    && apt-get install -y libpcl1 ros-noetic-octomap-*

# Clone Avoidance Module and build in Catkin workspace
RUN mkdir -p /root/catkin_ws/src && \
    cd /root/catkin_ws/src && \
    wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh && \
    chmod +x install_geographiclib_datasets.sh && \
    ./install_geographiclib_datasets.sh && \
    git clone https://github.com/PX4/avoidance.git && \
    /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin build -w /root/catkin_ws"
    
