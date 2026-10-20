-- =========================================================
-- BÀI THỰC HÀNH: TẠO VÀ SỬ DỤNG VIEW TRONG MYSQL
-- Cơ sở dữ liệu sử dụng: classicmodels
-- =========================================================

USE classicmodels;

------------------------------------------------------------
-- 1. TẠO VIEW ĐẦU TIÊN
-- Tạo View có tên customer_views để lấy các dữ liệu từ bảng customers
------------------------------------------------------------
CREATE VIEW customer_views AS 
SELECT customerNumber, customerName, phone 
FROM customers;

-- Truy vấn dữ liệu từ View vừa tạo
SELECT * FROM customer_views;


------------------------------------------------------------
-- 2. CẬP NHẬT / THAY THẾ VIEW (CREATE OR REPLACE VIEW)
-- Cập nhật lại view customer_views để thêm các cột mới và điều kiện lọc theo thành phố 'Nantes'
------------------------------------------------------------
CREATE OR REPLACE VIEW customer_views AS 
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone 
FROM customers 
WHERE city = 'Nantes';

-- Kiểm tra lại dữ liệu sau khi cập nhật View
SELECT * FROM customer_views;


------------------------------------------------------------
-- 3. XÓA VIEW (DROP VIEW)
-- Xóa View khi không còn sử dụng đến nữa
------------------------------------------------------------
DROP VIEW IF EXISTS customer_views;
