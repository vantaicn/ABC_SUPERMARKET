USE ABC_SUPERMARKET
GO

-- Phân hệ 1: Chăm sóc khách hàng (Thảo)

INSERT INTO loyal_rank
VALUES
('R001', N'Thân thiết', 0),
('R002', N'Đồng', 100000),
('R003', N'Bạc', 200000),
('R004', N'Vàng', 500000),
('R005', N'Bạch kim', 700000),
('R006', N'Kim cương', 1200000)

INSERT INTO customer
VALUES
('CUST00001', '1234567890', N'Nguyễn Văn An', '1990-05-15', '2022-01-10', 'R001'),
('CUST00002', '9876543210', N'Trần Trà Hương', '1985-08-25', '2021-07-20', 'R002'),
('CUST00003', '4567891230', N'Nguyễn Ngọc Ánh', '1992-12-10', '2023-03-15', NULL),
('CUST00004', '3216549870', N'Trần Hoàng Nam', '1988-03-03', '2022-11-05', 'R003'),
('CUST00005', '7891234560', N'Lý Hoàng Hà', '1995-09-17', '2021-06-22', 'R001'),
('CUST00006', '5678901234', N'Lê Thị Mỹ Duyên', '1997-04-22', '2020-09-01', 'R004'),
('CUST00007', '6789012345', N'Phạm Minh Tuấn', '1989-07-13', '2022-02-18', 'R005'),
('CUST00008', '7890123456', N'Võ Quang Huy', '1994-11-30', '2021-10-10', 'R006'),
('CUST00009', '8901234567', N'Bùi Thị Ngọc Lan', '1991-01-20', '2023-06-01', 'R001'),
('CUST00010', '9012345678', N'Trịnh Hồng Nhung', '1986-02-14', '2020-05-25', 'R002'),
('CUST00011', '9123456780', N'Hoàng Văn Minh', '1990-10-12', '2022-03-10', 'R003'),
('CUST00012', '9234567890', N'Nguyễn Thị Hồng', '1985-09-01', '2021-11-15', 'R004'),
('CUST00013', '9345678901', N'Phạm Anh Tuấn', '1992-03-21', '2023-01-25', 'R002'),
('CUST00014', '9456789012', N'Lê Thị Thu Hà', '1996-12-05', '2020-08-19', 'R001'),
('CUST00015', '9567890123', N'Trần Đức Long', '1989-06-17', '2021-02-14', 'R005'),
('CUST00016', '9678901234', N'Vũ Thị Lan Anh', '1994-04-30', '2022-07-07', 'R006'),
('CUST00017', '9789012345', N'Đỗ Minh Huyền', '1988-08-08', '2023-04-12', NULL),
('CUST00018', '9890123456', N'Trịnh Quốc Bảo', '1991-11-18', '2021-06-30', 'R002'),
('CUST00019', '9901234567', N'Lý Gia Huy', '1995-05-25', '2022-10-05', 'R003'),
('CUST00020', '9012345679', N'Thái Thanh Phương', '1993-01-08', '2020-09-17', 'R002'),
('CUST00021', '8123456789', N'Bùi Văn Hải', '1987-07-27', '2021-05-25', 'R001'),
('CUST00022', '8234567890', N'Trần Ngọc Mai', '1998-03-15', '2022-11-11', 'R002'),
('CUST00023', '8345678901', N'Nguyễn Hoàng Việt', '1992-12-25', '2023-02-20', 'R001'),
('CUST00024', '8456789012', N'Phạm Thị Kim Oanh', '1990-06-06', '2021-08-22', 'R002'),
('CUST00025', '8567890123', N'Lê Quốc Cường', '1995-02-14', '2022-01-01', 'R004');

insert into department (id, name, leader)
values 
('DEPT0001', N'Nhân sự', 'EMP001'),
('DEPT0002', N'Bán hàng', 'EMP003'),
('DEPT0003', 'IT', 'EMP005'),
('DEPT0004', N'Tài chính', 'EMP007'),
('DEPT0005', 'Marketing', 'EMP009')

insert into employee (id, name, gender, identification, phone_number, id_department)
values 
('EMP001', 'Trần Bạch Tuyết', N'Nữ', '123456789012345', '1234567890', 'DEPT0002'),
('EMP002', 'Nguyễn An Trung', 'Nam', '987654321098765', '9876543210', 'DEPT0002'),
('EMP003', 'Phạm Nam Thanh', 'Nam', '111122223333444', '4567891230', 'DEPT0002'),
('EMP004', 'Trần Trung Hiếu', 'Nam', '333344445555666', '7891234560', 'DEPT0001'),
('EMP005', N'Lê Minh Hương', N'Nữ', '555566667777888', '0123456789', 'DEPT0001'),
('EMP006', N'Nguyễn Văn Hùng', N'Nam', '666677778888999', '0987654321', 'DEPT0003'),
('EMP007', N'Phạm Ngọc Ánh', N'Nữ', '777788889999000', '0901234567', 'DEPT0002'),
('EMP008', N'Vũ Đức Mạnh', N'Nam', '888899990000111', '0912345678', 'DEPT0003'),
('EMP009', N'Trần Thị Thanh Hòa', N'Nữ', '999900001111222', '0923456789', 'DEPT0001'),
('EMP010', N'Hoàng Thị Lan', N'Nữ', '111122223333444', '0934567890', 'DEPT0003'),
('EMP011', N'Đỗ Quang Minh', N'Nam', '222233334444555', '0945678901', 'DEPT0002'),
('EMP012', N'Trịnh Huy Hoàng', N'Nam', '333344445555666', '0956789012', 'DEPT0001')

-- Phân hệ 2: Quản lý ngành hàng (Tài)

INSERT INTO Product (id, name, category, description, id_manufacturer, price, max_quantity, current_quantity)
VALUES
('P0001', N'Gạo Thơm Lài', N'Thực phẩm', N'Gạo thơm hạt dài', 'NSX001', 18000, 500, 300),
('P0002', N'Dầu Ăn Tường An', N'Thực phẩm', N'Dầu ăn 1L', 'NSX002', 35000, 400, 250),
('P0003', N'Sữa Tươi Vinamilk', N'Thực phẩm', N'Sữa tươi không đường', 'NSX003', 10000, 600, 400),
('P0004', N'Nước Ngọt Coca', N'Đồ uống', N'Nước ngọt Coca Cola 330ml', 'NSX004', 10000, 800, 500),
('P0005', N'Bột Giặt Omo', N'Hóa phẩm', N'Bột giặt Omo 2kg', 'NSX005', 45000, 200, 150),
('P0006', N'Bánh Oreo', N'Thực phẩm', N'Bánh quy Oreo 133g', 'NSX006', 20000, 500, 300),
('P0007', N'Kem Đánh Răng PS', N'Hóa phẩm', N'Kem đánh răng bảo vệ 123', 'NSX007', 18000, 400, 250),
('P0008', N'Trứng Gà Ta', N'Thực phẩm', N'Hộp 10 quả', 'NSX008', 35000, 300, 200),
('P0009', N'Bột Nêm Knorr', N'Gia vị', N'Bột nêm 400g', 'NSX009', 40000, 250, 150),
('P0010', N'Nước Mắm Nam Ngư', N'Gia vị', N'Nước mắm 750ml', 'NSX010', 45000, 300, 200),
('P0011', N'Bia Heineken', N'Đồ uống', N'Bia lon 330ml', 'NSX011', 15000, 1000, 700),
('P0012', N'Khăn Giấy Pulppy', N'Tiện ích', N'Khăn giấy hộp 180 tờ', 'NSX012', 20000, 300, 200),
('P0013', N'Sữa Chua Vinamilk', N'Thực phẩm', N'Sữa chua hương dâu', 'NSX003', 6000, 500, 400),
('P0014', N'Nước Suối Lavie', N'Đồ uống', N'Nước suối chai 500ml', 'NSX013', 5000, 1000, 800),
('P0015', N'Xúc Xích CP', N'Thực phẩm', N'Xúc xích tiệt trùng 200g', 'NSX014', 30000, 400, 300),
('P0016', N'Dầu Gội Head & Shoulders', N'Hóa phẩm', N'Dầu gội sạch gàu 850ml', 'NSX015', 120000, 150, 120),
('P0017', N'Bánh Mì Sandwich', N'Thực phẩm', N'Bánh mì sandwich 300g', 'NSX016', 20000, 300, 250),
('P0018', N'Kẹo Alpenliebe', N'Thực phẩm', N'Kẹo sữa hương caramel', 'NSX017', 10000, 400, 350),
('P0019', N'Phở Ăn Liền Acecook', N'Thực phẩm', N'Phở ăn liền gói 75g', 'NSX018', 10000, 500, 400),
('P0020', N'Trà Lipton', N'Đồ uống', N'Hộp trà túi lọc 100 gói', 'NSX019', 80000, 200, 150),
('P0021', N'Tương Ớt Chinsu', N'Gia vị', N'Tương ớt 500ml', 'NSX020', 25000, 300, 200),
('P0022', N'Bột Mì Meizan', N'Thực phẩm', N'Bột mì 1kg', 'NSX021', 25000, 400, 300),
('P0023', N'Kẹo Mút Chupa Chups', N'Thực phẩm', N'Hộp 50 que', 'NSX017', 60000, 100, 80),
('P0024', N'Nước Ngọt Pepsi', N'Đồ uống', N'Pepsi lon 330ml', 'NSX004', 10000, 800, 600),
('P0025', N'Đường Cát Trắng', N'Gia vị', N'Đường cát trắng 1kg', 'NSX022', 20000, 500, 400),
('P0026', N'Sữa Đặc Ông Thọ', N'Thực phẩm', N'Sữa đặc 380g', 'NSX003', 25000, 300, 200),
('P0027', N'Rau Muống Tươi', N'Rau củ', N'1 bó rau muống tươi', 'NSX023', 15000, 200, 150),
('P0028', N'Cà Chua', N'Rau củ', N'1kg cà chua tươi', 'NSX023', 30000, 150, 100),
('P0029', N'Táo Mỹ', N'Trái cây', N'1kg táo Mỹ nhập khẩu', 'NSX024', 80000, 100, 80),
('P0030', N'Chuối Tiêu', N'Trái cây', N'1kg chuối tiêu', 'NSX023', 20000, 200, 150),
('P0031', N'Sữa Chua Nếp Cẩm', N'Thực phẩm', N'Hộp 4 ly', 'NSX003', 20000, 400, 300),
('P0032', N'Khoai Tây', N'Rau củ', N'1kg khoai tây', 'NSX023', 30000, 200, 150),
('P0033', N'Nho Đen', N'Trái cây', N'1kg nho đen nhập khẩu', 'NSX024', 90000, 100, 80),
('P0034', N'Bánh ChocoPie', N'Thực phẩm', N'Hộp bánh 360g', 'NSX006', 35000, 400, 300),
('P0035', N'Hành Tây', N'Rau củ', N'1kg hành tây', 'NSX023', 25000, 300, 200),
('P0036', N'Cam Sành', N'Trái cây', N'1kg cam sành', 'NSX024', 50000, 200, 150),
('P0037', N'Bia Tiger', N'Đồ uống', N'Bia lon 330ml', 'NSX011', 15000, 800, 600),
('P0038', N'Nước Tương Maggi', N'Gia vị', N'Nước tương 500ml', 'NSX009', 20000, 300, 250),
('P0039', N'Cải Thảo', N'Rau củ', N'1kg cải thảo', 'NSX023', 20000, 200, 150),
('P0040', N'Nho Xanh', N'Trái cây', N'1kg nho xanh nhập khẩu', 'NSX024', 100000, 100, 70),
('P0041', N'Dưa Leo', N'Rau củ', N'1kg dưa leo', 'NSX023', 20000, 200, 150),
('P0042', N'Dầu Ăn Simply', N'Thực phẩm', N'Dầu ăn 5L', 'NSX002', 250000, 100, 80),
('P0043', N'Sữa Milo', N'Thực phẩm', N'Hộp sữa Milo 180ml', 'NSX003', 8000, 500, 400),
('P0044', N'Bánh Gạo One One', N'Thực phẩm', N'Gói bánh gạo 130g', 'NSX006', 15000, 400, 300),
('P0045', N'Tôm Khô', N'Thực phẩm', N'100g tôm khô', 'NSX025', 120000, 50, 40),
('P0046', N'Mắm Ruốc', N'Gia vị', N'Mắm ruốc 500g', 'NSX026', 45000, 100, 70),
('P0047', N'Nước Cốt Dừa', N'Thực phẩm', N'Nước cốt dừa 400ml', 'NSX027', 20000, 200, 150),
('P0048', N'Trà Sữa Matcha', N'Đồ uống', N'Hộp trà sữa Matcha', 'NSX019', 30000, 300, 200),
('P0049', N'Mì Gói Hảo Hảo', N'Thực phẩm', N'Gói mì 75g', 'NSX018', 5000, 1000, 900),
('P0050', N'Bột Ngọt Ajinomoto', N'Gia vị', N'Bột ngọt 400g', 'NSX028', 30000, 200, 150);


-- FlashSale
INSERT INTO Promotion (id, type, id_product, id_product_combo, discount, bronze_discount, silver_discount, gold_discount, platinum_discount, diamond_discount, start_date, end_date, max_quantity, used_quantity)
VALUES
('FS0001', 'Flash', 'P0001', NULL, 20, NULL, NULL, NULL, NULL, NULL, '2024-12-15', '2024-12-25', 50, 0),
('FS0002', 'Flash', 'P0002', NULL, 18, NULL, NULL, NULL, NULL, NULL, '2024-12-18', '2024-12-28', 55, 0),
('FS0003', 'Flash', 'P0003', NULL, 22, NULL, NULL, NULL, NULL, NULL, '2024-12-20', '2024-12-30', 60, 0),
('FS0004', 'Flash', 'P0004', NULL, 25, NULL, NULL, NULL, NULL, NULL, '2024-12-17', '2024-12-27', 45, 0),
('FS0005', 'Flash', 'P0005', NULL, 18, NULL, NULL, NULL, NULL, NULL, '2024-12-19', '2024-12-29', 70, 0),
('FS0006', 'Flash', 'P0006', NULL, 23, NULL, NULL, NULL, NULL, NULL, '2024-12-22', '2024-12-30', 65, 0),
('FS0007', 'Flash', 'P0007', NULL, 19, NULL, NULL, NULL, NULL, NULL, '2024-12-25', '2024-12-31', 55, 0),
('FS0008', 'Flash', 'P0008', NULL, 21, NULL, NULL, NULL, NULL, NULL, '2024-12-26', '2024-12-31', 60, 0),
('FS0009', 'Flash', 'P0009', NULL, 20, NULL, NULL, NULL, NULL, NULL, '2024-12-21', '2024-12-30', 75, 0),
('FS0010', 'Flash', 'P0010', NULL, 24, NULL, NULL, NULL, NULL, NULL, '2024-12-23', '2024-12-28', 80, 0);

-- ComboSale
INSERT INTO Promotion (id, type, id_product, id_product_combo, discount, bronze_discount, silver_discount, gold_discount, platinum_discount, diamond_discount, start_date, end_date, max_quantity, used_quantity)
VALUES
('CS0001', 'Combo', 'P0002', 'P0003', 15, NULL, NULL, NULL, NULL, NULL, '2024-12-17', '2024-12-27', 70, 0),
('CS0002', 'Combo', 'P0004', 'P0005', 16, NULL, NULL, NULL, NULL, NULL, '2024-12-20', '2024-12-30', 80, 0),
('CS0003', 'Combo', 'P0006', 'P0007', 18, NULL, NULL, NULL, NULL, NULL, '2024-12-18', '2024-12-28', 65, 0),
('CS0004', 'Combo', 'P0008', 'P0009', 17, NULL, NULL, NULL, NULL, NULL, '2024-12-22', '2024-12-30', 90, 0),
('CS0005', 'Combo', 'P0010', 'P0001', 20, NULL, NULL, NULL, NULL, NULL, '2024-12-24', '2024-12-31', 75, 0),
('CS0006', 'Combo', 'P0002', 'P0005', 14, NULL, NULL, NULL, NULL, NULL, '2024-12-19', '2024-12-29', 85, 0),
('CS0007', 'Combo', 'P0003', 'P0006', 15, NULL, NULL, NULL, NULL, NULL, '2024-12-21', '2024-12-30', 80, 0),
('CS0008', 'Combo', 'P0004', 'P0010', 19, NULL, NULL, NULL, NULL, NULL, '2024-12-23', '2024-12-31', 100, 0),
('CS0009', 'Combo', 'P0007', 'P0009', 16, NULL, NULL, NULL, NULL, NULL, '2024-12-25', '2024-12-30', 90, 0),
('CS0010', 'Combo', 'P0008', 'P0010', 18, NULL, NULL, NULL, NULL, NULL, '2024-12-26', '2024-12-31', 95, 0);

-- MemberSale
INSERT INTO Promotion (id, type, id_product, id_product_combo, discount, bronze_discount, silver_discount, gold_discount, platinum_discount, diamond_discount, start_date, end_date, max_quantity, used_quantity)
VALUES
('MS0001', 'Member', 'P0005', NULL, 5, 10, 12, 15, 18, 20, '2024-12-15', '2024-12-25', 60, 0),
('MS0002', 'Member', 'P0006', NULL, 7, 10, 12, 15, 18, 20, '2024-12-16', '2024-12-26', 65, 0),
('MS0003', 'Member', 'P0007', NULL, 6, 9, 11, 14, 17, 19, '2024-12-18', '2024-12-28', 70, 0),
('MS0004', 'Member', 'P0008', NULL, 8, 11, 13, 16, 19, 20, '2024-12-20', '2024-12-30', 80, 0),
('MS0005', 'Member', 'P0009', NULL, 6, 10, 12, 15, 17, 19, '2024-12-22', '2024-12-31', 85, 0),
('MS0006', 'Member', 'P0010', NULL, 10, 12, 14, 17, 20, 22, '2024-12-23', '2024-12-30', 75, 0),
('MS0007', 'Member', 'P0001', NULL, 9, 11, 13, 16, 18, 20, '2024-12-24', '2024-12-31', 90, 0),
('MS0008', 'Member', 'P0002', NULL, 5, 8, 10, 14, 17, 20, '2024-12-25', '2024-12-30', 95, 0),
('MS0009', 'Member', 'P0003', NULL, 7, 10, 12, 15, 18, 19, '2024-12-26', '2024-12-31', 85, 0),
('MS0010', 'Member', 'P0004', NULL, 6, 9, 12, 16, 18, 20, '2024-12-27', '2024-12-30', 70, 0);

-- Phân hệ 5: Phân hệ kinh doanh 
INSERT INTO Product_sold_report (id, date_report, id_product, quantity_sold, quantity_customer, id_employee)
VALUES
('RPT001', '2025-01-10', 'PRD001', 50, 20, 'EMP001'),
('RPT002', '2025-01-10', 'PRD002', 30, 15, 'EMP001'),
('RPT003', '2025-01-10', 'PRD003', 70, 25, 'EMP002'),
('RPT004', '2025-01-10', 'PRD004', 20, 10, 'EMP002'),
('RPT005', '2025-01-10', 'PRD005', 40, 18, 'EMP003');
GO

INSERT INTO Daily_report (id, date_report, total_customer, total_revenue, total_sold_products, id_employee)
VALUES
('DR001', '2025-01-10', 75, 5000000, 210, 'EMP001'),
('DR002', '2025-01-10', 85, 4500000, 220, 'EMP002'),
('DR003', '2025-01-10', 70, 5200000, 190, 'EMP003'),
('DR004', '2025-01-11', 60, 4800000, 160, 'EMP001'),
('DR005', '2025-01-11', 55, 5000000, 170, 'EMP002');
GO
