USE ABC_SUPERMARKET
GO

-- demo

--Unrepeatable Read
--sp_ProcessCustomerOrder đang đọc giá của một sản phẩm từ bảng Product,
--cùng lúc, sp_UpdateProductInfo muốn cập nhật giá của cùng sản phẩm đó
-- Start session 1: Simulate sp_ProcessCustomerOrder reading the product price
BEGIN TRANSACTION;

-- Lock the product row and read the price
DECLARE @product_price INT;
SELECT @product_price = price
FROM Product WITH (UPDLOCK, HOLDLOCK)
WHERE id = 'P0001';

-- Simulate processing delay (e.g., customer adding products to their cart)
WAITFOR DELAY '00:00:10'; -- 10 seconds delay to allow for conflict with session 2

-- Commit the transaction
COMMIT TRANSACTION;

-- Start session 2: Simulate sp_UpdateProductInfo updating the product price
BEGIN TRANSACTION;

-- Attempt to update the price of the same product
UPDATE Product
SET price = 22000
WHERE id = 'P0001';

-- Commit the transaction
COMMIT TRANSACTION;

--sp_TaoDonDatHang đang đọc số lượng tối đa của một sản phẩm từ bảng Product,
--cùng lúc, sp_UpdateProductInfo muốn cập nhật số lượng tối đa của cùng sản phẩm đó
BEGIN TRANSACTION;

-- Call sp_KiemTraVaTinhSoLuongDatHang to calculate order quantity (mock for demo)
DECLARE @quantity_order INT = 20; -- Simulated calculated order quantity

-- Read the max quantity of the product
SELECT max_quantity
FROM Product WITH (UPDLOCK, HOLDLOCK)
WHERE id = 'P0001';

-- Simulate processing delay for creating the order
WAITFOR DELAY '00:00:10'; -- 10 seconds delay to allow for conflict with session 2

-- Insert a new import order
DECLARE @id_order CHAR(10) = 'ORD00001';
INSERT INTO ImportOrder (
    id, 
    id_product, 
    date_order, 
    quantity_order, 
    id_employee,
    status
)
VALUES (
    @id_order, 
    'P0001', 
    GETDATE(), 
    @quantity_order, 
    'EMP001',
    'PENDING'
);

-- Commit the transaction
COMMIT TRANSACTION;

BEGIN TRANSACTION;

-- Attempt to update the max quantity of the same product
UPDATE Product
SET max_quantity = 120
WHERE id = 'P0001';

-- Commit the transaction
COMMIT TRANSACTION;

--sp_ProcessCustomerOrder đang đọc thông tin (phần trăm khuyến mãi, ngày kết thúc, 
--số lượng sản phẩm tối đa) của một chương trình khuyến mãi Flash Sale từ bảng Promotion, 
--cùng lúc, sp_UpdateFlashSale muốn cập nhật thông tin (phần trăm khuyến mãi, ngày kết thúc, 
--số lượng sản phẩm tối đa) của cùng chương trình khuyến mãi đó

BEGIN TRANSACTION;

-- Simulate reading the Flash Sale promotion details
SELECT discount, end_date, max_quantity
FROM Promotion WITH (UPDLOCK, HOLDLOCK)
WHERE id = 'PROMO001' AND type = 'Flash';

-- Simulate a delay in processing the order
WAITFOR DELAY '00:00:10'; -- 10 seconds delay to allow for conflict with session 2

-- Assuming further processing happens here...

COMMIT TRANSACTION;

BEGIN TRANSACTION;

-- Attempt to update the Flash Sale promotion details
UPDATE Promotion
SET 
    discount = 25,
    end_date = '2025-01-31',
    max_quantity = 60
WHERE id = 'PROMO001' AND type = 'Flash';

-- Commit the transaction
COMMIT TRANSACTION;



