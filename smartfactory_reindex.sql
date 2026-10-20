-- =========================================================
-- TỐI ƯU HÓA HỆ THỐNG INDEX CHO BẢNG SENSORLOGS (SMARTFACTORY)
-- =========================================================

USE smartfactory_db;

-- 1. Kiểm tra kích thước dung lượng Data và Index trước khi tối ưu
SELECT 
    table_name AS `Table`,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS `Total Size (MB)`,
    ROUND((data_length / 1024 / 1024), 2) AS `Data Size (MB)`,
    ROUND((index_length / 1024 / 1024), 2) AS `Index Size (MB)`
FROM information_schema.TABLES
WHERE table_schema = 'smartfactory_db' 
  AND table_name = 'SensorLogs';


-- 2. Xóa bỏ Fat Index cũ (idx_fat_covering) gây tốn dung lượng và chậm lệnh INSERT
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;


-- 3. Tạo Lean Index mới tinh gọn hơn (chỉ giữ lại các cột thực sự cần thiết cho việc lọc: sensor_id, recorded_at)
CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);


-- 4. Chạy câu lệnh EXPLAIN để kiểm tra lại truy vấn của Dashboard
EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 
  AND recorded_at >= '2026-06-20';


-- 5. Kiểm tra lại kích thước dung lượng Data và Index SAU KHI tối ưu
SELECT 
    table_name AS `Table`,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS `Total Size (MB)`,
    ROUND((data_length / 1024 / 1024), 2) AS `Data Size (MB)`,
    ROUND((index_length / 1024 / 1024), 2) AS `Index Size (MB)`
FROM information_schema.TABLES
WHERE table_schema = 'smartfactory_db' 
  AND table_name = 'SensorLogs';
