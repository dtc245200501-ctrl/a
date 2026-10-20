# Nhật ký Tương tác AI (Prompt Log)

- **Câu hỏi trao đổi 1:** *"Giả sử bảng dữ liệu của chúng ta không phải là IoT lưu liên tục, mà là bảng 'Danh mục quốc gia' (Countries) cả năm không ai sửa, thì việc tạo Covering Index có còn là một 'tội ác' hay không?"*
  - **Phân tích/Giải đáp:** Trong trường hợp bảng tĩnh (không có thao tác `INSERT`, `UPDATE`, `DELETE`), hiện tượng *Write Penalty* bằng 0. Do đó, việc sử dụng *Covering Index* hoàn toàn không phải là tội ác mà là một chiến lược tối ưu tuyệt vời để đạt tốc độ đọc (`SELECT`) tối đa mà không tốn chi phí bảo trì ghi.

- **Câu hỏi trao đổi 2:** *"Write Penalty của Index là gì? Tại sao thêm 1 cột vào Index lại làm quá trình INSERT chậm lại?"*
  - **Phân tích/Giải đáp:** Index được tổ chức dưới dạng cấu trúc cây B-Tree. Khi thêm cột vào Index, kích thước mỗi node tăng lên, đồng thời cấu trúc cây phải duy trì tính sắp xếp thứ tự. Khi có lệnh `INSERT` dữ liệu mới, hệ thống không chỉ ghi vào bảng mà phải tính toán vị trí, phân tách node và cập nhật lại cây B-Tree cho mọi Index hiện hữu, dẫn đến tốn kém tài nguyên CPU và I/O đĩa.
