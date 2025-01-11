USE ABC_SUPERMARKET
GO

-- Phân hệ 1: Chăm sóc khách hàng (Thảo)

CREATE PROCEDURE sp_AddCustomer
	@id CHAR(10),
	@phone_number CHAR(10),
	@name NVARCHAR(50),
	@birthday DATE
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO customer(id_customer, phone_number, name, birthdate, registration_date)
		VALUES (@id, @phone_number, @name, @birthday, getdate())
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END
    END CATCH
	COMMIT TRANSACTION
END
GO

CREATE PROCEDURE sp_EditCustomerInfo
	@id CHAR(10),
	@phone_number CHAR(10),
	@name NVARCHAR(50),
	@birthday DATE
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	BEGIN TRY

		UPDATE customer
		SET phone_number = COALESCE(@phone_number, phone_number),
			name = COALESCE(@name, name), 
			birthdate = COALESCE(@birthday, birthdate)
		WHERE id_customer = @id

	END TRY
	BEGIN CATCH
        if @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END
    END CATCH
	COMMIT TRANSACTION
END
GO

CREATE PROCEDURE sp_CalCustomerLastYearExpense
    @id CHAR(10),
    @start_date DATE,
    @end_date DATE,
    @total_expense INT OUTPUT
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	BEGIN TRY

		SET @total_expense = 0;

		SELECT @total_expense = ISNULL(SUM(total_price), 0)
		FROM orders
		WHERE id_customer = @id AND create_date BETWEEN @start_date AND @end_date
	END TRY
	BEGIN CATCH
        if @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END
    END CATCH
	COMMIT TRANSACTION
END
GO

CREATE PROCEDURE sp_RankCustomer
AS
BEGIN
    DECLARE @id_customer CHAR(10);
	DECLARE @registration_date DATE;
    DECLARE @total_expense INT;
    DECLARE @start_date DATE;
    DECLARE @end_date DATE;
    DECLARE @new_rank CHAR(10);
	
	DECLARE customer_cursor CURSOR FAST_FORWARD FOR
	SELECT id_customer, registration_date
	FROM customer;

	OPEN customer_cursor;

	FETCH NEXT FROM customer_cursor INTO @id_customer, @registration_date;

	-- Loop through each customer
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
		BEGIN TRANSACTION;

			BEGIN TRY
			
				SET @end_date = DATEFROMPARTS(YEAR(GETDATE()), MONTH(@registration_date), DAY(@registration_date))
				IF @end_date <= GETDATE()
				BEGIN

					-- Define the date range (last year)
					SET @start_date = dateadd(year, -1, @end_date)

					-- Call sp_CalCustomerLastYearExpense to get total expense
					EXEC sp_CalCustomerLastYearExpense @id = @id_customer, 
													   @start_date = @start_date, 
													   @end_date = @end_date, 
													   @total_expense = @total_expense OUTPUT

					-- Determine new loyalty rank based on total expense
					SET @new_rank = CASE 
						WHEN @total_expense >= 50000000 THEN 'R006'
						WHEN @total_expense >= 30000000 THEN 'R005'
						WHEN @total_expense >= 15000000 THEN 'R004'
						WHEN @total_expense >= 5000000 THEN 'R003'
						WHEN @total_expense >= 2500000 THEN 'R002'
						ELSE 'R001'                                
					END

					-- Update the customer's rank
					UPDATE customer
					SET id_rank = @new_rank
					WHERE id_customer = @id_customer
				END
			END TRY

			BEGIN CATCH
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION
				END

				-- Log error
				PRINT 'Error processing customer: ' + @id_customer

			END CATCH
		
		-- Commit transaction
		COMMIT TRANSACTION

        -- Fetch the next customer
        FETCH NEXT FROM customer_cursor into @id_customer, @registration_date
    END

    -- Close and deallocate the cursor
    CLOSE customer_cursor
    DEALLOCATE customer_cursor
END
GO

CREATE PROCEDURE sp_InformGift
AS
BEGIN

    DECLARE @id_customer CHAR(10)
    DECLARE @name NVARCHAR(50)
    DECLARE @phone_number CHAR(10)
    DECLARE @birthdate date
    DECLARE @id_rank CHAR(10)
    DECLARE @coupon INT

    DECLARE birthday_cursor CURSOR FAST_FORWARD FOR
    SELECT c.id_customer, c.name, c.phone_number, c.birthdate, c.id_rank, lr.coupon
    FROM customer c
    JOIN loyal_rank lr on c.id_rank = lr.id_rank
    WHERE MONTH(c.birthdate) = MONTH(GETDATE())

    OPEN birthday_cursor

    -- Fetch the first customer
    FETCH NEXT FROM birthday_cursor into @id_customer, @name, @phone_number, @birthdate, @id_rank, @coupon

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
		BEGIN TRANSACTION
		BEGIN TRY
			PRINT concat('Sending coupon of ', @coupon, ' VND to ', @name, ' (Phone: ', @phone_number, ') on birthday: ', @birthdate)
		END TRY

		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
			END

			-- Log error
			PRINT 'Error processing customer: ' + @id_customer

		END CATCH

		-- Commit transaction
		COMMIT TRANSACTION

		-- Fetch the next customer
        FETCH NEXT FROM birthday_cursor INTO @id_customer, @name, @phone_number, @birthdate, @id_rank, @coupon
    END;

    -- Close and deallocate the cursor
    CLOSE birthday_cursor
    DEALLOCATE birthday_cursor
END
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

-- Phân hệ 5: Phân hệ kinh doanh 
CREATE PROCEDURE sp_AddDailyReport (
    @id CHAR(10),
    @date_report DATE,
    @id_employee CHAR(10)
)
AS
BEGIN
    BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    DECLARE @total_customer INT;
    DECLARE @total_revenue INT;
    DECLARE @total_sold_products INT;

    -- Tính tổng số khách hàng mua, tổng doanh thu
    SELECT @total_customer = COUNT(DISTINCT id_customer), @total_revenue = SUM(total_price)
    FROM Order WITH (HOLDLOCK, UPDLOCK)
    WHERE create_date = @date_report;

    -- Tính tổng số sản phẩm đã bán trong ngày
    SELECT @total_sold_products = SUM(DO.quantity)
    FROM Detail_order DO WITH (HOLDLOCK, UPDLOCK)
    INNER JOIN Order O ON DO.id_order = O.id
    WHERE O.create_date = @date_report;


    -- Lưu kết quả vào bảng Daily_report
    INSERT INTO Daily_report (id, date_report, total_customer, total_revenue, total_sold_products, id_employee)
    VALUES (@id, @date_report, @total_customer, @total_revenue, @total_sold_products, @id_employee);

	COMMIT;
END;
GO

CREATE PROCEDURE sp_AddProductSoldReport (
    @id CHAR(10),
    @date_report DATE,
    @id_employee CHAR(10)
)
AS
BEGIN
    BEGIN TRANSACTION;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    INSERT INTO Product_sold_report (id, date_report, id_product, quantity_sold, quantity_customer, id_employee)
    SELECT 
        @id, 
        @date_report,
        DO.id_product,
        SUM(DO.quantity) AS quantity_sold,
        COUNT(DISTINCT O.id_customer) AS quantity_customer,
        @id_employee
    FROM Detail_order DO WITH (HOLDLOCK, UPDLOCK)
    INNER JOIN Order O WITH (HOLDLOCK, UPDLOCK) ON DO.id_order = O.id
    WHERE O.create_date = @date_report
    GROUP BY DO.id_product
    ORDER BY quantity_sold DESC;

    COMMIT;
END;
GO