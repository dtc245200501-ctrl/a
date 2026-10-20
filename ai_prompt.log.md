# Nhật ký Tương tác AI (Prompt Log)

- **Câu hỏi trao đổi 1:** *"Trong MySQL, nếu tôi tạo Index trên một cột chứa văn bản dài (TEXT) và một cột kiểu BOOLEAN (0 và 1), thì điều này gây hại như thế nào đến bộ nhớ RAM, dung lượng Disk và bộ tối ưu hóa (Query Optimizer)?"*
  - **Phân tích/Giải đáp:** Cột `TEXT` có kích thước lớn làm cây B-Tree phình to, tốn kém dung lượng Disk và làm chậm nghiêm trọng các thao tác ghi (INSERT/UPDATE). Cột `BOOLEAN` có độ phân giải dữ liệu (Cardinality) quá thấp (chỉ có 2 giá trị), khiến MySQL Optimizer tính toán thấy việc quét toàn bảng (Full Table Scan) nhanh hơn việc đi qua Index, dẫn đến Index đó trở nên vô dụng nhưng vẫn ngốn chi phí bảo trì[cite: 13, 14].

- **Câu hỏi trao đổi 2:** *"Tại sao khi truy vấn SELECT * FROM Posts WHERE is_visible = 1 trên một bảng có hàng triệu dòng (trong đó 99% bài viết là visible = 1), MySQL lại quyết định quét toàn bảng thay vì sử dụng Index idx_is_visible đã tạo?"*
  - **Phân tích/Giải đáp:** Do tính chất phân bố dữ liệu (Cardinality thấp), khi 99% dữ liệu đều thỏa mãn điều kiện `is_visible = 1`, nếu dùng Index, MySQL sẽ phải thực hiện thêm bước lookup ngược lại bảng chính cho hầu hết các dòng, tốn kém chi phí hơn rất nhiều so với việc đọc tuần tự một lượt toàn bộ bảng (Full Table Scan). Do đó, việc xóa bỏ các Index dạng này là hoàn toàn chính xác[cite: 14, 15].
