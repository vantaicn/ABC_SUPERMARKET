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

-- Phân hệ 5: Phân hệ kinh doanh 

CREATE TABLE Product_sold_report (
	id CHAR(10),
	date_report DATE,
	id_product CHAR(10),
	quantity_sold INT,
	quantity_customer INT,
	id_employee CHAR(10),
	PRIMARY KEY (id, id_product),
	FOREIGN KEY (id_product) REFERENCES Product(id),
	FOREIGN KEY (id_employee) REFERENCES Employee(id),
);
GO

CREATE TABLE Daily_report (
	id CHAR(10) PRIMARY KEY,
	date_report DATE,
	total_customer CHAR(10),
	total_revenue INT,
	total_sold_products INT,
	id_employee CHAR(10),
	FOREIGN KEY (id_employee) REFERENCES Employee(id),
);
GO

