# Báo cáo Phân tích Đánh đổi Hiệu năng (Index Trade-off) - Smartfactory

## 1. Vấn đề ban đầu (Fat Index)
- Hệ thống Smartfactory sử dụng *Covering Index* (`idx_fat_covering`) bao trùm toàn bộ các cột[cite: 24, 25]. Điều này giúp Dashboard đọc dữ liệu cực nhanh do không cần lookup bảng gốc, nhưng đổi lại gây ra hiện tượng **Write Penalty** cực lớn[cite: 24, 26]. Mỗi khi hàng nghìn cảm biến gửi dữ liệu về mỗi giây, thao tác `INSERT` phải sắp xếp lại toàn bộ các khối dữ liệu trên cây B-Tree của Index, làm Data Pipeline bị nghẽn và hóa đơn Cloud tăng vọt do kích thước Index lớn hơn cả bảng dữ liệu gốc[cite: 24, 25].

## 2. Giải pháp Lean Index và Kết quả
- **Hành động:** Đã tiến hành gỡ bỏ `idx_fat_covering` và thiết kế lại *Lean Index* (`idx_lean_search`) chỉ chứa 2 cột lọc chính là `(sensor_id, recorded_at)`[cite: 25].
- **Đánh đổi & Kết quả:** Tốc độ câu lệnh `SELECT` trên Dashboard có thể chậm hơn một phần nghìn giây do MySQL thực hiện thêm bước lookup nhỏ lấy cột `temperature` và `humidity` từ bảng gốc[cite: 25]. Tuy nhiên, đổi lại tốc độ ghi (`INSERT`) được cải thiện gấp 5 lần, dung lượng ổ đĩa của Index giảm tới 70%, giải phóng hoàn toàn tài nguyên hệ thống và cứu vãn ngân sách[cite: 25].
