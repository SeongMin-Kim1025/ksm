# Stage 1: Base Image with ROS and Avoidance Module
FROM ksm/ros-noetic:v1
ARG DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies for PX4 Firmware
RUN apt-get update && \
    apt-get install -y git make g++ gcc libc-dev \
    cmake libpython3-dev python3-numpy python3-pip \
    libyaml-cpp-dev libopencv-dev gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev

# Clone PX4 Firmware and install dependencies
RUN apt-get install -y lsb-release && \
    git clone https://github.com/PX4/Firmware.git --recursive /root/Firmware && \
    cd /root/Firmware && \
    chmod +x ./Tools/setup/ubuntu.sh && \
    sed -i 's/sudo //g' ./Tools/setup/ubuntu.sh && \  
    ./Tools/setup/ubuntu.sh --no-sim-tools --no-nuttx && \
    apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev

# Build PX4 Firmware once to generate SDF model files for Gazebo
RUN cd /root/Firmware && \
    export QT_X11_NO_MITSHM=1 && \
    #HEADLESS=1 make px4_sitl_default gazebo
    DONT_RUN=1 make px4_sitl_default gazebo

# Install xmlstarlet for Gazebo sdf models
RUN apt install -y xmlstarlet

# Configure Gazebo and ROS environment variables
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
    echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    echo ". ~/Firmware/Tools/simulation/gazebo-classic/setup_gazebo.bash ~/Firmware ~/Firmware/build/px4_sitl_default" >> ~/.bashrc

# Set environment variables for ROS and Gazebo
RUN echo "export ROS_PACKAGE_PATH=/root/catkin_ws/src/avoidance/avoidance:/root/catkin_ws/src/avoidance/global_planner:/root/catkin_ws/src/avoidance/local_planner:/root/catkin_ws/src/avoidance/safe_landing:/opt/ros/noetic/share:/root/Firmware" >> ~/.bashrc && \
    echo "export GAZEBO_MODEL_PATH=/root/Firmware/Tools/simulation/gazebo-classic/sitl_gazebo-classic/models:/root/catkin_ws/src/avoidance/avoidance/sim/models:/root/catkin_ws/src/avoidance/avoidance/sim/worlds" >> ~/.bashrc
    
# Install nano
RUN apt-get install nano

# Set entry point to bash
CMD ["bash"]


