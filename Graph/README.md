# Về bài vẽ đồ thị

## A) Tính năng đã có
- Vẽ đồ thị của các hàm bậc 1,2,3,4... ; hàm phân thức ; hàm sin, cos  mà người dùng nhập vào
- Có TextField để nhập hàm
- Có hệ trục toạ độ
- Có các nút phóng to thu nhỏ tất cả hoặc theo chiều ngang hay dọc
- Swipe để di chuyển vùng xem
- Pinch để phóng to thu nhỏ toàn bộ

## B) Ý tưởng
- Dùng ScrollView
- Đặt 1 UIView tên "a" có origin trùng với tâm ScrollView, điểm này là gốc toạ độ.
- Dùng UIBezierPath để vẽ đường thẳng, nhiều đường thẳng nhỏ hợp thành đường cong. Các đường thẳng vẽ lên View "a"
- Các nút và TextField add lên view chính để lúc swipe không bị trôi mất
- Có 2 biến lưu độ zoom theo chiều x và y. Khi có yêu cầu sẽ vẽ lại hình với độ zoom mới

## C) Hạn chế
- Do dùng NSExpression để tính giá trị nên cú pháp phải tuân theo quy định
Ví dụ như cú pháp cho   ký tự mũ là    **   chứ không phải    ^
                                        hàm sin là      function(biểu thức hợp lệ, 'sin')
Hàm sin với cos trong project này là extension cho NSNumber
- Phải dùng code Objective C mới catch được NSException
