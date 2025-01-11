USE MASTER
GO
DROP DATABASE ABC_SUPERMARKET
GO
CREATE DATABASE ABC_SUPERMARKET
GO
USE ABC_SUPERMARKET
GO

-- Phân hệ 1: Chăm sóc khách hàng (Thảo)
CREATE TABLE Loyal_rank(
id_rank CHAR(10) CONSTRAINT pk_loyal_rank PRIMARY KEY,
name NVARCHAR(20) NOT NULL,
coupon INT,
)


CREATE TABLE Customer(
id_customer CHAR(10) CONSTRAINT pk_customer PRIMARY KEY,
phone_number CHAR(10) UNIQUE,
name NVARCHAR(50),
birthdate DATE NOT NULL,
registration_date DATE NOT NULL,
id_rank CHAR(10) CONSTRAINT df_idrank DEFAULT 1,
CONSTRAINT fk_customer_loyalRank FOREIGN KEY (id_rank) REFERENCES loyal_rank(id_rank),
)

CREATE TABLE department(
id char(10) CONSTRAINT pk_department PRIMARY KEY,
name NVARCHAR(30),
leader CHAR(10)
)

CREATE TABLE employee(
id CHAR(10) CONSTRAINT pk_employee PRIMARY KEY,
name NVARCHAR(30),
gender NVARCHAR(5),
identification CHAR(15),
phone_number CHAR(10),
id_department CHAR(10)
CONSTRAINT fk_employee_department FOREIGN KEY (id_department) REFERENCES department(id)
)

CREATE TABLE Manufacturer(
id CHAR(10) CONSTRAINT pk_manufacturer PRIMARY KEY,
name NCHAR(30),
address NVARCHAR(50),
phone_number CHAR(10)
)

-- Phân hệ 2: Quản lý ngành hàng (Tài)

CREATE TABLE Product (
    id CHAR(10) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    category NVARCHAR(30),
    description NVARCHAR(100),
    id_manufacturer CHAR(10),
    price INT NOT NULL,
    max_quantity INT NOT NULL,
    current_quantity INT,
	CONSTRAINT fk_product_manufacturer FOREIGN KEY (id_manufacturer) REFERENCES manufacturer(id)
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


-- Phân hệ 3: Quản lý đơn hàng (Thành)
-- Tạo bảng Order
CREATE TABLE "Order" (
    id_order CHAR(10) PRIMARY KEY,
    id_customer CHAR(10) NOT NULL,
    create_date DATE NOT NULL,
    total_price INT NOT NULL,
    processing_employee CHAR(10),
    FOREIGN KEY (id_customer) REFERENCES Customer(id_customer),
    FOREIGN KEY (processing_employee) REFERENCES Employee(id)
);

-- Tạo bảng Detail_order
CREATE TABLE Detail_order (
    id_order CHAR(10),
    id_product CHAR(10),
    quantity INT NOT NULL,
    price INT NOT NULL,
    id_sale CHAR(10),
    total_price INT NOT NULL,
    PRIMARY KEY (id_order, id_product),
    FOREIGN KEY (id_order) REFERENCES "Order"(id_order),
    FOREIGN KEY (id_product) REFERENCES Product(id),
    FOREIGN KEY (id_sale) REFERENCES Promotion(id)
);


-- Phân hệ 4: Quản lý kho hàng (Thuận)
CREATE TABLE ImportOrder (
    id CHAR(10) PRIMARY KEY,       
    id_product CHAR(10) NOT NULL,  
    id_employee CHAR(10), 
    quantity_order INT,   
    quantity_receive INT , 
    date_order DATE,      
    date_receive DATE,             
    status nvarchar(10),
    FOREIGN KEY (id_product) REFERENCES Product(id)
)
go


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

