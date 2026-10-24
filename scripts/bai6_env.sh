#!/usr/bin/env bash
# Source this file in each terminal before starting an individual demo node.
bai6_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$bai6_root" || return 1
if [[ ! -f "$bai6_root/install/setup.bash" ]]; then
    echo 'Chưa build Bài 6. Chạy: source /opt/ros/humble/setup.bash && colcon build --symlink-install' >&2
    return 1
fi
source /opt/ros/humble/setup.bash || return 1
source "$bai6_root/install/setup.bash" || return 1
if [[ -f "$bai6_root/.venv-gesture/bin/activate" ]]; then
    source "$bai6_root/.venv-gesture/bin/activate"
fi
export ROS_DOMAIN_ID=86
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
unset ROS_LOCALHOST_ONLY
export CYCLONEDDS_URI="file://$bai6_root/config/cyclonedds_gesture.xml"
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 LP_NUM_THREADS=2
export ROS_LOG_DIR="$bai6_root/log/manual/ros"
mkdir -p "$ROS_LOG_DIR"
