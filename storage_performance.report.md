# Báo cáo Đánh giá Hiệu năng và Dung lượng Lưu trữ - Dự án Quickfeed

## 1. Nguyên nhân gây chậm và lỗi Timeout
- **Vấn đề:** Trước khi tối ưu, bảng `Posts` bị lạm dụng tạo Index trên hầu hết các cột (Over-indexing)[cite: 13, 14]. 
- **Hậu quả:** Mỗi khi có một lệnh `INSERT` (đăng bài viết mới) hoặc `UPDATE`/`DELETE` xảy ra, cơ sở dữ liệu không chỉ ghi dữ liệu vào bảng chính mà phải cập nhật lại cấu trúc cây B-Tree cho **5 Index khác nhau**. Điều này làm gia tăng đáng kể số lượng thao tác ghi đĩa, gây hiện tượng nghẽn cổ chai và dẫn đến lỗi **Timeout** (mất 5-10 giây mới thành công)[cite: 13, 14]. Ngoài ra, dung lượng của riêng các Index đã lớn gấp đôi dung lượng dữ liệu thực tế, làm bộ nhớ RAM bị quá tải[cite: 13, 14].

## 2. Giải pháp và Kết quả thực thi
- **Hành động:** Đã tiến hành "phẫu thuật cắt bỏ" 3 Index kém hiệu quả gồm `idx_content` (trường TEXT dung lượng lớn), `idx_post_type` và `idx_is_visible` (độ phân giải dữ liệu - Cardinality cực thấp)[cite: 14, 15, 16]. Giữ lại 2 Index thiết yếu là `idx_user_id` (tính phân biệt cao để load trang cá nhân) và `idx_created_at` (phục vụ sắp xếp Newsfeed)[cite: 14, 16].
- **Kết quả:** Sau khi chạy script tối ưu, dung lượng ổ đĩa (`Index_length`) đã giảm từ hàng Gigabyte xuống chỉ còn vài Megabyte[cite: 15, 16]. Tốc độ thực hiện câu lệnh `INSERT` được cải thiện rõ rệt, loại bỏ hoàn toàn hiện tượng chậm và lỗi Timeout.
