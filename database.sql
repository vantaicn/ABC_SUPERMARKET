USE MASTER
GO
DROP DATABASE ABC_SUPERMARKET
GO
CREATE DATABASE ABC_SUPERMARKET
GO
USE ABC_SUPERMARKET
GO



-- Phân hệ 2: Quản lý ngành hàng (Tài)

CREATE TABLE Product (
    id CHAR(10) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    category NVARCHAR(30),
    description NVARCHAR(100),
    id_manufacturer CHAR(10),
    price INT NOT NULL,
    max_quantity INT NOT NULL,
    current_quantity INT
);

CREATE TABLE Promotion (
    id CHAR(10) PRIMARY KEY,
    type VARCHAR(20),
    id_product CHAR(10),
    id_product_combo CHAR(10),
    discount INT,
    bronze_discount INT,
    silver_discount INT,
    gold_discount INT,
    platinum_discount INT,
    diamond_discount INT,
    start_date DATE,
    end_date DATE,
    max_quantity INT,
    used_quantity INT,
    FOREIGN KEY (id_product) REFERENCES Product(id),
    FOREIGN KEY (id_product_combo) REFERENCES Product(id)
);

