USE ABC_SUPERMARKET
GO




-- Phân hệ 2: Quản lý ngành hàng (Tài)

CREATE PROCEDURE sp_AddProduct
    @id CHAR(10),
    @name NVARCHAR(50),
    @category NVARCHAR(30),
    @description NVARCHAR(100),
    @idManufacturer CHAR(10),
    @price INT,
    @maxQuantity INT,
    @currentQuantity INT
AS
BEGIN
    INSERT INTO Product (id, name, category, description, id_manufacturer, price, max_quantity, current_quantity)
    VALUES (@id, @name, @category, @description, @idManufacturer, @price, @maxQuantity, @currentQuantity)
END;
GO


CREATE PROCEDURE sp_UpdateProductInfo
    @id CHAR(10),
    @name NVARCHAR(50),
    @category NVARCHAR(30),
    @description NVARCHAR(100),
    @idManufacturer CHAR(10),
    @price INT,
    @maxQuantity INT
AS
BEGIN
    UPDATE Product
    SET 
        name = @name,
        category = @category,
        description = @description,
        id_manufacturer = @idManufacturer,
        price = @price,
        max_quantity = @maxQuantity
    WHERE id = @id;
END;
GO

CREATE PROCEDURE sp_AddFlashSale
    @id CHAR(10),
    @idProduct CHAR(10),
    @discount INT,
    @startDate DATE,
    @endDate DATE,
    @maxQuantity INT,
    @usedQuantity INT
AS
BEGIN
    INSERT INTO Promotion (id, type, id_product, discount, start_date, end_date, max_quantity, used_quantity)
    VALUES (@id, 'Flash', @idProduct, @discount, @startDate, @endDate, @maxQuantity, @usedQuantity)
END;
GO

CREATE PROCEDURE sp_AddComboSale
    @id CHAR(10),
    @idProduct CHAR(10),
    @idProductCombo CHAR(10),
    @discount INT,
    @startDate DATE,
    @endDate DATE,
    @maxQuantity INT,
    @usedQuantity INT
AS
BEGIN
    INSERT INTO Promotion (id, type, id_product, id_product_combo, discount, start_date, end_date, max_quantity, used_quantity)
    VALUES (@id, 'Combo', @idProduct, @idProductCombo, @discount, @startDate, @endDate, @maxQuantity, @usedQuantity)
END;
GO

CREATE PROCEDURE sp_AddMemberSale
    @id CHAR(10),
    @idProduct CHAR(10),
    @discount INT,
    @bronzeDiscount INT,
    @silverDiscount INT,
    @goldDiscount INT,
    @platinumDiscount INT,
	@diamondDiscount INT,
    @startDate DATE,
    @endDate DATE,
    @maxQuantity INT,
    @usedQuantity INT
AS
BEGIN
    INSERT INTO Promotion (id, type, id_product, discount, bronze_discount, silver_discount, gold_discount, platinum_discount, diamond_discount, start_date, end_date, max_quantity, used_quantity)
    VALUES (@id, 'Member', @idProduct, @discount, @bronzeDiscount, @silverDiscount, @goldDiscount, @platinumDiscount, @diamondDiscount, @startDate, @endDate, @maxQuantity, @usedQuantity)
END;
GO

CREATE PROCEDURE sp_UpdateFlashSale
    @id CHAR(10),
    @discount INT,
    @endDate DATE,
    @maxQuantity INT
AS
BEGIN
    UPDATE Promotion
    SET 
        discount = @discount,
        end_date = @endDate,
        max_quantity = @maxQuantity
    WHERE id = @id AND type = 'Flash';
END;
GO

CREATE PROCEDURE sp_UpdateComboSale
    @id CHAR(10),
    @discount INT,
    @endDate DATE,
    @maxQuantity INT
AS
BEGIN
    UPDATE Promotion
    SET 
        discount = @discount,
        end_date = @endDate,
        max_quantity = @maxQuantity
    WHERE id = @id AND type = 'Combo';
END;
GO

CREATE PROCEDURE sp_UpdateMemberSale
    @id CHAR(10),
    @discount INT,
    @bronzeDiscount INT,
    @silverDiscount INT,
    @goldDiscount INT,
    @platinumDiscount INT,
	@diamondDiscount INT,
    @endDate DATE,
    @maxQuantity INT
AS
BEGIN
    UPDATE Promotion
    SET 
        discount = @discount,
        bronze_discount = @bronzeDiscount,
        silver_discount = @silverDiscount,
        gold_discount = @goldDiscount,
        platinum_discount = @platinumDiscount,
        diamond_discount = @diamondDiscount,
        end_date = @endDate,
        max_quantity = @maxQuantity
    WHERE id = @id AND type = 'Member';
END;
GO
