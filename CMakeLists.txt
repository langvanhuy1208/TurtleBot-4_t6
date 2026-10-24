cmake_minimum_required(VERSION 3.8)
project(tb4_simplesimu)
find_package(ament_cmake REQUIRED)
install(DIRECTORY launch config scripts urdf worlds DESTINATION share/${PROJECT_NAME})
install(PROGRAMS
  scripts/gesture_recognition_node.py
  scripts/robot_behavior_node.py
  scripts/download_gesture_model.py
  DESTINATION lib/${PROJECT_NAME})
install(FILES scripts/gesture_core.py DESTINATION lib/${PROJECT_NAME})
ament_package()
