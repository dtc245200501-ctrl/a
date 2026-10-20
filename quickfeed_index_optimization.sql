-- =========================================================
-- TỐI ƯU HÓA HỆ THỐNG INDEX CHO BẢNG POSTS (QUICKFEED)
-- =========================================================

USE quickfeed_db;

-- 1. Kiểm tra kích thước Data và Index của bảng Posts trước khi tối ưu (Tính theo Megabyte)
SELECT 
    table_name AS `Table`,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS `Total Size (MB)`,
    ROUND((data_length / 1024 / 1024), 2) AS `Data Size (MB)`,
    ROUND((index_length / 1024 / 1024), 2) AS `Index Size (MB)`
FROM information_schema.TABLES
WHERE table_schema = 'quickfeed_db' 
  AND table_name = 'Posts';


-- 2. Xóa bỏ các Index kém hiệu quả (Over-indexing / Low Cardinality / Quá lớn)
-- - Xóa idx_content trên cột TEXT (Gây tốn dung lượng ổ cứng khủng khiếp, tìm kiếm văn bản dài nên dùng Full-text Search)
ALTER TABLE Posts DROP INDEX idx_content;

-- - Xóa idx_post_type (Cardinality quá thấp, chỉ có vài giá trị 'TEXT', 'IMAGE', 'VIDEO')
ALTER TABLE Posts DROP INDEX idx_post_type;

-- - Xóa idx_is_visible (Cardinality quá thấp, chỉ có 2 giá trị True/False, Optimizer thường quét toàn bảng hiệu quả hơn)
ALTER TABLE Posts DROP INDEX idx_is_visible;


-- 3. Kiểm tra lại kích thước Data và Index SAU KHI tối ưu
SELECT 
    table_name AS `Table`,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS `Total Size (MB)`,
    ROUND((data_length / 1024 / 1024), 2) AS `Data Size (MB)`,
    ROUND((index_length / 1024 / 1024), 2) AS `Index Size (MB)`
FROM information_schema.TABLES
WHERE table_schema = 'quickfeed_db' 
  AND table_name = 'Posts';
