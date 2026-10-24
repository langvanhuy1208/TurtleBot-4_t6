# Chạy Bài 6 thủ công trên máy hiện tại

Thư mục bài độc lập:

```text
/home/huy/tb4_simplesimu/release/TurtleBot-4_t6
```

Đây là bản dùng để đưa lên GitHub. Mã ban đầu đã chạy thử nằm trong
`/home/huy/tb4_simplesimu`; dùng bản độc lập bên trên cho các lần chạy sau.

## Cách nhanh: một terminal

```bash
cd /home/huy/tb4_simplesimu/release/TurtleBot-4_t6
./scripts/run_bai6_live.sh
```

Chờ khoảng 20 giây. Script mở Gazebo, webcam và hai node ROS 2.
Đổi webcam: `./scripts/run_bai6_live.sh 2` nếu thiết bị của bạn là video2.
Ctrl+C trong terminal để dừng toàn bộ.

## Cách thủ công: ba terminal

Đóng phiên demo cũ trước, tránh mở hai simulator hoặc hai node cùng điều
khiển robot. Mỗi terminal phải nạp cùng môi trường bằng `bai6_env.sh`.
Script môi trường chỉ cấu hình ROS/venv, không tự khởi chạy node.

**Terminal 1 — Gazebo và TurtleBot 4:**

```bash
cd /home/huy/tb4_simplesimu/release/TurtleBot-4_t6
source scripts/bai6_env.sh
ros2 launch tb4_simplesimu gesture_sim.launch.py
```

Chờ robot xuất hiện và dock được xóa sau khoảng 20 giây.

**Terminal 2 — bộ điều khiển hành vi:**

```bash
cd /home/huy/tb4_simplesimu/release/TurtleBot-4_t6
source scripts/bai6_env.sh
ros2 launch tb4_simplesimu gesture_control.launch.py start_camera:=false
```

**Terminal 3 — webcam và nhận diện AI:**

```bash
cd /home/huy/tb4_simplesimu/release/TurtleBot-4_t6
source scripts/bai6_env.sh
python scripts/gesture_recognition_node.py --ros-args \
  --params-file config/gesture.yaml \
  -p model_path:="$PWD/models/gesture_recognizer.task" \
  -p camera_index:=0
```

Môi trường Python và mô hình đã được lưu trong thư mục bài trên máy này,
không phụ thuộc các file thử nghiệm ở `/tmp`. Chúng được Git bỏ qua nên
không upload lên repository. Máy khác cần cài đặt theo README.

## Thử cử chỉ

1. Giơ một ngón để chọn tiến–lùi; hai ngón để chọn vòng tròn.
2. Thấy `SELECTED`, đổi sang ngón cái trong vòng 5 giây để chạy.
3. Giữ tay hợp lệ trong khung hình trong suốt hành vi.
4. Xòe tay để dừng ngay; nắm tay để hủy.
5. Vẫy tay ngang đủ ba lượt rồi giơ ngón cái để robot chào.

Khi đã chạy mà mất tay hoặc mất tín hiệu, robot dừng và cần chọn lại.
Không mở teleop/Nav2 đồng thời với bài này.

## Dừng và kiểm tra

Xòe tay để robot dừng. Sau đó Ctrl+C ở terminal 3, 2, rồi 1.

Để xem topic trong terminal thứ tư:

```bash
cd /home/huy/tb4_simplesimu/release/TurtleBot-4_t6
source scripts/bai6_env.sh
ros2 topic echo /robot_behavior/status
```

Nếu sửa mã rồi cần build lại:

```bash
cd /home/huy/tb4_simplesimu/release/TurtleBot-4_t6
source /opt/ros/humble/setup.bash
colcon build --symlink-install --packages-select tb4_simplesimu
```

Nếu clone vào thư mục khác, thay đường dẫn `cd` trong hướng dẫn. Các script
tự xác định vị trí dự án nên không cần sửa đường dẫn bên trong script.
