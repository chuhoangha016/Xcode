#  Ứng dụng memory game

Kịch bản màn hình gồm nhiều ô chữ nhật, người dùng tap vào để lật ô chữ nhật.

## Yêu cầu

1. Sử dụng được với 2 chế độ Potrait và Landscape
2. Người dùng cấu hình được chế độ chơi dễ (ít ô cần lật, tốc độ chơi chậm ) - trung bình - khó (nhiều ô cần lật tốc độ chơi nhanh)
3. Có âm thanh phát ra khi lập và chơi cho phấn khích


## Các bước tiến hành

### Cấu trúc dữ liệu - giải thuật

1. Tạo một timer đếm ngược thời gian. Nếu thời gian hết mà các ô không được lật thì người dùng thua. Nếu người dùng lật hết các ô khi thời gian còn người dùng thắng
2. Cần một mảng hai chiều (2 dimension array), mỗi phần tử mảng thể hiện một ô.
3. Mỗi ô sẽ gồm có các thuộc tính như sau:
    
    - row, col: hàng cột trong mảng
    - giá trị phân biệt kiểu int để so sánh với các ô khác
    - ảnh đại diện cho giá trị. Mỗi giá trị integer sẽ ánh xạ vào một ảnh minh họa. Chỉ cần dùng một mảng array photo là ok.
    - trạng thái kiểu bool: được lật hay chưa. Mặc định là chưa (false)
    
4. Cần tạo một class game manager dạng singleton để quản lý: cấp độ khó, hoặc lưu trạng thái game đang chơi dở dang, lưu thành tích chơi của người chơi database của ứng dụng


### Trình tự thực hiện

Ứng dụng có rất nhiều chức năng khác nhau, hãy bắt đầu từ những chức năng căn bản, bắt buộc phải có, sau đó mới đến chức năng bổ xung, thêm thắt.

1. Tạo ra một mảng 2 chiều để vẽ các ô lật
2. Sử dụng Stevia framework để layout giao diện cho nhanh
3. Tạo một custom UIView để chứa và quản lý tất cả các ô lật. Gọi nó là Board

- Board có một data structure là mảng 2 chiều mô tả trạng thái các ô: ảnh, giá trị (chất) để so sánh với ô khác, trạng thái đã được lật hay chưa?
- 
3. Tạo một progress view hiển thị thời gian còn lại

## Học được gì

Có 2 cách call back phổ biến trong iOS Swift:
1. Sử dụng protocol - delegate
2. Truyền hàm closure vào một thuộc tính. Khi cần kích hoạt closure

Áp dụng [Solid Pattern](https://scotch.io/bar-talk/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)
