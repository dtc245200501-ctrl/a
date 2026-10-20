-- =========================================================
-- BÀI THỰC HÀNH TỔNG HỢP: VIEW, INDEX VÀ STORED PROCEDURE
-- =========================================================

-- Bước 1: Tạo cơ sở dữ liệu demo
CREATE DATABASE demo_products_db;
USE demo_products_db;

-- Bước 2: Tạo bảng Products và chèn dữ liệu mẫu
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription TEXT,
    productStatus VARCHAR(50) NOT NULL
);

-- Chèn dữ liệu mẫu vào bảng Products
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus) VALUES
('P001', 'Laptop Dell', 1500.00, 10, 'Core i5, RAM 8GB', 'Active'),
('P002', 'Mouse Logitech', 25.50, 50, 'Wireless mouse', 'Active'),
('P003', 'Keyboard Mechanical', 75.00, 30, 'RGB mechanical keyboard', 'Active'),
('P004', 'Monitor LG', 200.00, 15, '24 inch Full HD', 'Out of Stock');


-- =========================================================
-- Bước 3: THỰC HÀNH INDEX
-- =========================================================
-- Tạo Unique Index trên cột productCode
ALTER TABLE Products ADD UNIQUE INDEX idx_productCode(productCode);

-- Tạo Composite Index trên 2 cột productName và productPrice
ALTER TABLE Products ADD INDEX idx_name_price(productName, productPrice);

-- Sử dụng câu lệnh EXPLAIN để kiểm tra truy vấn trước và sau khi tạo index
EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';
EXPLAIN SELECT * FROM Products WHERE productName = 'Mouse Logitech' AND productPrice = 25.50;


-- =========================================================
-- Bước 4: THỰC HÀNH VIEW
-- =========================================================
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus
CREATE VIEW view_products AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Xem dữ liệu từ View
SELECT * FROM view_products;

-- Tiến hành sửa/cập nhật View (Ví dụ: thêm điều kiện lọc sản phẩm Active)
CREATE OR REPLACE VIEW view_products AS
SELECT productCode, productName, productPrice, productStatus
FROM Products
WHERE productStatus = 'Active';

-- Tiến hành xoá View khi không cần dùng
DROP VIEW IF EXISTS view_products;


-- =========================================================
-- Bước 5: THỰC HÀNH STORED PROCEDURE (CRUD)
-- =========================================================
DELIMITER //

-- 1. Lấy tất cả thông tin của tất cả sản phẩm
DROP PROCEDURE IF EXISTS findAllProducts //
CREATE PROCEDURE findAllProducts()
BEGIN
    SELECT * FROM Products;
END //

-- 2. Thêm một sản phẩm mới
DROP PROCEDURE IF EXISTS insertProduct //
CREATE PROCEDURE insertProduct(
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_desc TEXT,
    IN p_status VARCHAR(50)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_desc, p_status);
END //

-- 3. Sửa thông tin sản phẩm theo id
DROP PROCEDURE IF EXISTS updateProductById //
CREATE PROCEDURE updateProductById(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT
)
BEGIN
    UPDATE Products 
    SET productName = p_name, 
        productPrice = p_price, 
        productAmount = p_amount
    WHERE id = p_id;
END //

-- 4. Xoá sản phẩm theo id
DROP PROCEDURE IF EXISTS deleteProductById //
CREATE PROCEDURE deleteProductById(
    IN p_id INT
)
BEGIN
    DELETE FROM Products WHERE id = p_id;
END //

DELIMITER ;


-- =========================================================
-- KIỂM TRA CÁC STORED PROCEDURE
-- =========================================================
CALL findAllProducts();
-- CALL insertProduct('P005', 'Headphones', 50.00, 20, 'Bluetooth headphones', 'Active');
-- CALL updateProductById(1, 'Laptop Dell XPS', 1800.00, 8);
-- CALL deleteProductById(4);
