-- =========================================================
-- BÀI THỰC HÀNH: SỬ DỤNG TRIGGER TRONG MYSQL
-- =========================================================

-- Bước 1: Tạo CSDL và Bảng
CREATE DATABASE company;

USE company;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);


-- Bước 2: Tạo Trigger tự động cập nhật phòng ban (department) dựa theo mức lương (salary)
DELIMITER //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;


-- Bước 3: Demo sử dụng trigger (Thêm dữ liệu kiểm tra)
INSERT INTO employees (name, department, salary)
VALUES 
    ('John Doe', 'A', 2500),
    ('Jane Smith', 'A', 3500),
    ('David Johnson', 'A', 6000);

-- Kiểm tra kết quả sau khi chèn dữ liệu
SELECT * FROM employees;
