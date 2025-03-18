-- Intitialize
USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Asm_G1')
BEGIN
	ALTER DATABASE Asm_G1 SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE Asm_G1 SET ONLINE;
	DROP DATABASE Asm_G1;
END
GO

CREATE DATABASE Asm_G1;
GO

USE Asm_G1
GO

-- 1
CREATE TABLE UserAccounts(
UserID INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
AccountName NVARCHAR(60) NOT NULL UNIQUE,
UserName NVARCHAR(60) NOT NULL,
[Password] NVARCHAR(20) NOT NULL,
[Role] NVARCHAR(15) NOT NULL, 
Email NVARCHAR(200) NOT NULL CHECK (Email LIKE '%@%.%') UNIQUE,
CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
);
GO

-- 2
CREATE TABLE Categories( 
CategoryID INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
CategoryName NVARCHAR (60),
[Description] NVARCHAR(3000)
);
GO

-- 3
CREATE TABLE Products(
ProductID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
ProductName NVARCHAR(300) NOT NULL,
CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID) ON DELETE CASCADE,
UnitsInStock INT NOT NULL,
UnitPrice INT,
Discount INT DEFAULT 0,
Images NVARCHAR(300) DEFAULT NULL
);
GO

-- 6
CREATE TABLE Carts(
    UserID INT NOT NULL FOREIGN KEY REFERENCES UserAccounts(UserID) ON DELETE CASCADE,
    CartID INT NOT NULL,
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
    Quantity INT,
    CONSTRAINT pk_Carts PRIMARY KEY (UserID, CartID)
);
GO


-- 4
CREATE TABLE Purchased(
UserID INT NOT NULL FOREIGN KEY REFERENCES UserAccounts(UserID) ON DELETE CASCADE,
PurchasedID INT NOT NULL,
ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE, --
Quantity INT,
PurchasedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
Freight INT,
CONSTRAINT pk_Purchased PRIMARY KEY (UserID, PurchasedID, ProductID)
);
GO



CREATE TABLE Orders(
UserID INT NOT NULL FOREIGN KEY REFERENCES UserAccounts(UserID) ON DELETE CASCADE,
OrderID INT NOT NULL,
ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE, --
Quantity INT,
OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
Freight INT,
RequiredDate DATETIME DEFAULT DATEADD(DAY, 7, CURRENT_TIMESTAMP),
CONSTRAINT pk_Orders PRIMARY KEY (UserID, OrderID)
);
GO

-- 5
CREATE TABLE Payments(
UserID INT NOT NULL FOREIGN KEY REFERENCES UserAccounts(UserID) ON DELETE CASCADE,
PaymentID INT NOT NULL,
PaymentMethod NVARCHAR(50),
PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
Price INT DEFAULT NULL,
);
GO
	
-- 7
CREATE TABLE Reviews(
ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID) ON DELETE CASCADE,
ReviewID INT NOT NULL,
UserID INT NOT NULL FOREIGN KEY REFERENCES UserAccounts(UserID) ON DELETE CASCADE,
Rating INT NOT NULL CHECK(Rating >= 1 AND Rating <= 5),
Comment NVARCHAR(300) DEFAULT NULL,
ReviewDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_review PRIMARY KEY(UserID, ProductID)
);
GO

---- Function
--CREATE VIEW CalPriceInPayments
--AS
--SELECT p.PaymentID, SUM((od.Quantity * pd.UnitPrice)* (100 - pd.Discount) / 100) + o.Freight AS TotalPrice
--FROM Payments AS p
--INNER JOIN Orders AS o
--ON p.OrderID = o.OrderID
--INNER JOIN OrderDetails AS od
--ON od.OrderID = o.OrderID
--INNER JOIN Products AS pd
--ON pd.ProductID = od.ProductID
--GROUP BY p.PaymentID, o.Freight;
--GO

--UPDATE Payments
--SET Price = cp.TotalPrice
--FROM Payments p
--INNER JOIN [dbo].[CalPriceInPayments] AS cp
--ON p.PaymentID = cp.PaymentID;
--GO

CREATE TRIGGER HandleInsertInCart
ON Carts
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng của người dùng
    UPDATE c
    SET c.Quantity = c.Quantity + i.Quantity
    FROM Carts c
    INNER JOIN inserted i
        ON c.UserID = i.UserID
        AND c.ProductID = i.ProductID;

    -- 2. Nếu sản phẩm chưa có trong giỏ hàng, thêm bản ghi mới với CartID tự động tăng
    INSERT INTO Carts (UserID, CartID, ProductID, Quantity)
    SELECT 
        i.UserID,
        ISNULL(
            (SELECT MAX(c.CartID) FROM Carts c WHERE c.UserID = i.UserID), 
            0
        ) + 1 AS NewCartID,
        i.ProductID,
        i.Quantity
    FROM inserted i
    WHERE NOT EXISTS (
        SELECT 1
        FROM Carts c
        WHERE c.UserID = i.UserID
        AND c.ProductID = i.ProductID
    );
END;
GO

CREATE TRIGGER InsertInOrderUpdateQuantity
ON Orders
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng của người dùng
    UPDATE o
    SET o.Quantity = o.Quantity + i.Quantity
    FROM Orders o
    INNER JOIN inserted i
        ON o.UserID = i.UserID
        AND o.ProductID = i.ProductID;

    -- 2. Nếu sản phẩm chưa có trong giỏ hàng, thêm bản ghi mới với CartID tự động tăng
    INSERT INTO Orders (UserID, OrderID, ProductID, Quantity, Freight)
    SELECT 
        i.UserID,
        ISNULL(
            (SELECT MAX(o.OrderID) FROM Orders o WHERE o.UserID = i.UserID), 
            0
        ) + 1 AS NewCartID,
        i.ProductID,
        i.Quantity,
		i.Freight
    FROM inserted i
    WHERE NOT EXISTS (
        SELECT 1
        FROM Orders o
        WHERE o.UserID = i.UserID
        AND o.ProductID = i.ProductID
    );

    -- 3. Cập nhật UnitsInStock trong Products dựa trên số lượng mới thêm vào Carts
    UPDATE Products
    SET UnitsInStock = UnitsInStock - i.Quantity
    FROM Products p
    INNER JOIN inserted i ON p.ProductID = i.ProductID;
END 
GO

CREATE TRIGGER HandleInsertInPayment
ON Payments
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    
    -- 1. Nếu sản phẩm chưa có trong giỏ hàng, thêm bản ghi mới với PaymentID tự động tăng
    INSERT INTO Payments (UserID, PaymentID, PaymentMethod, Price)
    SELECT 
        i.UserID,
        ISNULL(
            (SELECT MAX(p.PaymentID) FROM Payments p WHERE p.UserID = i.UserID), 
            0
        ) + 1 AS NewPaymentID,
        i.PaymentMethod,
        i.Price
    FROM inserted i
    
END;
GO

CREATE TRIGGER HandleInsertInReview
ON Reviews
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    
    -- 1. Nếu sản phẩm chưa có trong giỏ hàng, thêm bản ghi mới với ReviewID tự động tăng
    INSERT INTO Reviews (ProductID, ReviewID, UserID, Rating, Comment)
    SELECT 
        i.ProductID,
        ISNULL(
            (SELECT MAX(r.ReviewID) FROM Reviews r WHERE r.ProductID = i.ProductID), 
            0
        ) + 1 AS NewReviewID,
        i.UserID,
        i.Rating,
		i.Comment
    FROM inserted i
    
END;
GO

-- Data
INSERT INTO UserAccounts (AccountName, Username, [Password], Role, Email) 
values 
('Admin_1', 'admin1', '123', 'Admin', 'admin1@gmail.com'),
('Admin_2', 'admin2', '123', 'Admin', 'admin2@gmail.com'),
('phan_minh_tri', N'Phan Minh Trí', '1234', 'User', 'phanminhtri@gmail.com'), 
('thai_tri_nhan', N'Thái Trí Nhân', '1234', 'User', 'thaitrinhan@gmail.com'), 
('hoang_thi_thuy_tra', N'Hoàng Thị Thúy Trà', '1234', 'User', 'hoangthithuytra@gmail.com'), 
('hoang_trung_duc', N'Hoàng Trung Đức', '1234', 'User', 'hoangtrungduc@gmail.com'), 
('nguyen_nguyet_minh', N'Nguyễn Nguyệt Minh', '1234', 'User', 'nguyennguyetminh@gmail.com'), 
('student', N'Student', '1234', 'User', 'student@gmail.com'), 
('tran_phuc_thinh', N'Trần Phúc Thịnh', '1234', 'User', 'tranphucthinh@gmail.com'), 
('nguyen_hieu_trung', N'Nguyễn Hiếu Trung', '1234', 'User', 'nguyenhieutrung@gmail.com'), 
('tran_van_anh', N'Trần Văn Anh', '1234', 'User', 'tranvananh@gmail.com'), 
('le_thanh_thuy', N'Lê Thanh Thủy', '1234', 'User', 'lethanhthuy@gmail.com'), 
('cu_phi_quang_hao', N'Cù Phi Quang Hào', '1234', 'User', 'cuphiquanghao@gmail.com'), 
('chau_trong_nam', N'Châu Trọng Nam', '1234', 'User', 'chautrongnam@gmail.com'), 
('nguyen_minh_phuong', N'Nguyễn Minh Phương', '1234', 'User', 'nguyenminhphuong@gmail.com'), 
('truong_van_tuan', N'Trương Văn Tuấn', '1234', 'User', 'truongvantuan@gmail.com'), 
('phung_duc_lam', N'Phùng Đức Lâm', '1234', 'User', 'phungduclam@gmail.com'), 
('co_gia_bao', N'Cổ Gia Bảo', '1234', 'User', 'cogiabao@gmail.com'), 
('luong_nguyen_minh_tri', N'Lương Nguyễn Minh Trí', '1234', 'User', 'luongnguyenminhtri@gmail.com'), 
('dang_thanh_tuc', N'Đặng Thanh Túc', '1234', 'User', 'dangthanhtuc@gmail.com'), 
('tran_van_chung', N'Trần Văn Chung', '1234', 'User', 'tranvanchung@gmail.com'), 
('le_hai_yen', N'Lê Hải Yến', '1234', 'User', 'lehaiyen@gmail.com'), 
('huynh_hoang_phuc', N'Huỳnh Hoàng Phúc', '1234', 'User', 'huynhhoangphuc@gmail.com'), 
('nguyen_ngoc_phuc', N'Nguyễn Ngọc Phúc', '1234', 'User', 'nguyenngocphuc@gmail.com'), 
('le_viet_hung', N'Lê Viết Hưng', '1234', 'User', 'leviethung@gmail.com'), 
('nguyen_huynh_tai', N'Nguyễn Huỳnh Tài', '1234', 'User', 'nguyenhuynhtai@gmail.com'), 
('tran_truong_long_hai', N'Trần Trương Long Hải', '1234', 'User', 'trantruonglonghai@gmail.com'), 
('huynh_ngoc_hung', N'Huỳnh Ngọc Hưng', '1234', 'User', 'huynhngochung@gmail.com'), 
('phung_thai_khanh', N'Phùng Thái Khanh', '1234', 'User', 'phungthaikhanh@gmail.com'), 
('tran_huu_duc', N'Trần Hữu Đức', '1234', 'User', 'tranhuuduc@gmail.com'), 
('nguyen_giang_dao', N'Nguyễn Giang Đảo', '1234', 'User', 'nguyengiangdao@gmail.com'), 
('vo_truong_anh_tuan', N'Võ Trương Anh Tuấn', '1234', 'User', 'votruonganhtuan@gmail.com'), 
('hoang_trong_cuong', N'Hoàng Trọng Cường', '1234', 'User', 'hoangtrongcuong@gmail.com'), 
('nguyen_van_luc', N'Nguyễn Văn Lực', '1234', 'User', 'nguyenvanluc@gmail.com'), 
('cao_minh_khoi', N'Cao Minh Khôi', '1234', 'User', 'caominhkhoi@gmail.com'), 
('nguyen_thi_thuy', N'Nguyễn Thị Thuý', '1234', 'User', 'nguyenthithuy@gmail.com'), 
('ho_minh_tuan', N'Hồ Minh Tuấn', '1234', 'User', 'hominhtuan@gmail.com'), 
('do_thanh_hai', N'Đỗ Thanh Hải', '1234', 'User', 'dothanhhai@gmail.com'), 
('tran_quoc_thai', N'Trần Quốc Thái', '1234', 'User', 'tranquocthai@gmail.com'), 
('vu_anh_khoa', N'Vũ Anh Khoa', '1234', 'User', 'vuanhkhoa@gmail.com'), 
('nguyen_minh_quan', N'Nguyễn Minh Quân', '1234', 'User', 'nguyenminhquan@gmail.com'), 
('nguyen_thanh_hiep', N'Nguyễn Thành Hiệp', '1234', 'User', 'nguyenthanhhiep@gmail.com'), 
('ho_cong_luan', N'Hồ Công Luận', '1234', 'User', 'hocongluan@gmail.com'), 
('tran_gia_huy', N'Trần Gia Huy', '1234', 'User', 'trangiahuy@gmail.com'), 
('pham_thanh_binh', N'Phạm Thanh Bình', '1234', 'User', 'phamthanhbinh@gmail.com'), 
('kieu_van_phuoc', N'Kiều Văn Phước', '1234', 'User', 'kieuvanphuoc@gmail.com'), 
('huynh_nguyen_bao_quoc', N'Huỳnh Nguyễn Bảo Quốc', '1234', 'User', 'huynhnguyenbaoquoc@gmail.com'), 
('le_van_thong', N'Lê Văn Thống', '1234', 'User', 'levanthong@gmail.com'), 
('tran_minh_truc', N'Trần Minh Trực', '1234', 'User', 'tranminhtruc@gmail.com'), 
('nguyen_thanh_viet', N'Nguyễn Thành Việt', '1234', 'User', 'nguyenthanhviet@gmail.com'), 
('hoang_phuong_nam', N'Hoàng Phương Nam', '1234', 'User', 'hoangphuongnam@gmail.com'), 
('tran_ba_giap', N'Trần Bá Giáp', '1234', 'User', 'tranbagiap@gmail.com'), 
('pham_hai_dang', N'Phạm Hải Đăng', '1234', 'User', 'phamhaidang@gmail.com'), 
('nguyen_quang_vinh', N'Nguyễn Quang Vinh', '1234', 'User', 'nguyenquangvinh@gmail.com'), 
('pham_khuong_duy', N'Phạm Khương Duy', '1234', 'User', 'phamkhuongduy@gmail.com'), 
('nguyen_truong_doanh', N'Nguyễn Trường Doanh', '1234', 'User', 'nguyentruongdoanh@gmail.com'), 
('doan_huynh_vong', N'Đoàn Huỳnh Vọng', '1234', 'User', 'doanhuynhvong@gmail.com'), 
('nguyen_tien_linh', N'Nguyễn Tiến Linh', '1234', 'User', 'nguyentienlinh@gmail.com'), 
('nguyen_anh_tuan', N'Nguyễn Anh Tuấn', '1234', 'User', 'nguyenanhtuan@gmail.com'), 
('nguyen_trong_vu_huy', N'Nguyễn Trọng Vũ Huy', '1234', 'User', 'nguyentrongvuhuy@gmail.com'), 
('nguyen_van_uy', N'Nguyễn Văn Uy', '1234', 'User', 'nguyenvanuy@gmail.com'), 
('hoang_manh_cuong', N'Hoàng Mạnh Cường', '1234', 'User', 'hoangmanhcuong@gmail.com'), 
('nguyen_dung_phuong', N'Nguyễn Dũng Phương', '1234', 'User', 'nguyendungphuong@gmail.com'), 
('dinh_tien_sy', N'Đinh Tiến Sỹ', '1234', 'User', 'dinhtiensy@gmail.com'), 
('dang_lam_hai_dang', N'Đặng Lâm Hải Đăng', '1234', 'User', 'danglamhaidang@gmail.com'), 
('tran_tuan_anh', N'Trần Tuấn Anh', '1234', 'User', 'trantuananh@gmail.com'), 
('doan_duy_phuong', N'Đoàn Duy Phương', '1234', 'User', 'doanduyphuong@gmail.com'), 
('nguyen_tri_phuc', N'Nguyễn Trí Phúc', '1234', 'User', 'nguyentriphuc@gmail.com'), 
('tran_hoang_long', N'Trần Hoàng Long', '1234', 'User', 'tranhoanglong@gmail.com'), 
('hoang_trong_nghich', N'Hoàng Trọng Nghịch', '1234', 'User', 'hoangtrongnghich@gmail.com'), 
('nguyen_thi_my_hai', N'Nguyễn Thị Mỹ Hải', '1234', 'User', 'nguyenthimyhai@gmail.com'), 
('nguyen_thi_anh', N'Nguyễn Thị Ánh', '1234', 'User', 'nguyenthianh@gmail.com'), 
('kinh_quang_thang', N'Kinh Quang Thắng', '1234', 'User', 'kinhquangthang@gmail.com'), 
('nguyen_thi_to_tri', N'Nguyễn Thị Tố Tri', '1234', 'User', 'nguyenthitotri@gmail.com'), 
('le_ngoc_huy', N'Lê Ngọc Huy', '1234', 'User', 'lengochuy@gmail.com'), 
('pham_quoc_thao', N'Phạm Quốc Thảo', '1234', 'User', 'phamquocthao@gmail.com'), 
('nguyen_tran_dinh_nguyen', N'Nguyễn Trần Đình Nguyên', '1234', 'User', 'nguyentrandinhnguyen@gmail.com'), 
('pham_tuan_duy', N'Phạm Tuấn Duy', '1234', 'User', 'phamtuanduy@gmail.com'), 
('hoang_quoc_vuong', N'Hoàng Quốc Vượng', '1234', 'User', 'hoangquocvuong@gmail.com'), 
('nguyen_cong_thanh', N'Nguyễn Công Thành', '1234', 'User', 'nguyencongthanh@gmail.com'), 
('nguyen_tuan_dat', N'Nguyễn Tuấn Đạt', '1234', 'User', 'nguyentuandat@gmail.com'), 
('ngo_kieu_anh', N'Ngô Kiều Anh', '1234', 'User', 'ngokieuanh@gmail.com'), 
('huynh_cong_dinh', N'Huỳnh Công Định', '1234', 'User', 'huynhcongdinh@gmail.com'), 
('hoang_van_huynh', N'Hoàng Văn Huynh', '1234', 'User', 'hoangvanhuynh@gmail.com'), 
('le_thai_binh', N'Lê Thái Bình', '1234', 'User', 'lethaibinh@gmail.com'), 
('lam_hai_duong', N'Lâm Hải Dương', '1234', 'User', 'lamhaiduong@gmail.com'), 
('nguyen_tuan_ngoc', N'Nguyễn Tuấn Ngọc', '1234', 'User', 'nguyentuanngoc@gmail.com'), 
('duong_van_nam', N'Dương Văn Nam', '1234', 'User', 'duongvannam@gmail.com'), 
('dao_phi_minh', N'Đào Phi Minh', '1234', 'User', 'daophiminh@gmail.com'), 
('le_thi_ai_hang', N'Lê Thị ái Hằng', '1234', 'User', 'lethiaihang@gmail.com'), 
('mai_van_khai', N'Mai Văn Khải', '1234', 'User', 'maivankhai@gmail.com'), 
('le_thi_tai_ngan', N'Lê Thị Tài Ngân', '1234', 'User', 'lethitaingan@gmail.com'), 
('nguyen_van_tinh', N'Nguyễn Văn Tịnh', '1234', 'User', 'nguyenvantinh@gmail.com'), 
('le_thi_quynh_chau', N'Lê Thị Quỳnh Châu', '1234', 'User', 'lethiquynhchau@gmail.com'), 
('trinh_quoc_vinh', N'Trịnh Quốc Vinh', '1234', 'User', 'trinhquocvinh@gmail.com'), 
('le_thanh_hai', N'Lê Thanh Hải', '1234', 'User', 'lethanhhai@gmail.com'), 
('vuong_huynh_le_thien', N'Vương Huỳnh Lê Thiện', '1234', 'User', 'vuonghuynhlethien@gmail.com'), 
('nguyen_thanh_tam', N'Nguyễn Thanh Tâm', '1234', 'User', 'nguyenthanhtam@gmail.com'), 
('pham_minh_quan', N'Phạm Minh Quân', '1234', 'User', 'phamminhquan@gmail.com'), 
('pham_xuan_thong', N'Phạm Xuân Thông', '1234', 'User', 'phamxuanthong@gmail.com'), 
('nguyen_van_phong', N'Nguyễn Văn Phong', '1234', 'User', 'nguyenvanphong@gmail.com'), 
('pham_thanh_phong', N'Phạm Thanh Phong', '1234', 'User', 'phamthanhphong@gmail.com')


INSERT INTO Categories(CategoryName, Description)
VALUES
(N'Hoa tai', N'Bông tai bạc nữ đính đá'),
(N'Lắc tay', N'Vòng tay nữ phong cách'),
(N'Dây chuyền', N'Dây chuyền bạc nữ đẹp cao cấp'),
(N'Nhẫn', N'Những chiếc nhẫn bạc nữ được thiết kế với đá quý lấp lánh, tạo điểm nhấn và sự quý phái cho người đeo.'),
(N'Lắc chân', N'Thêm chút duyên dáng với bộ sưu tập lắc chân tinh tế!')

INSERT INTO Products(ProductName, CategoryID, UnitsInStock, UnitPrice, Discount, Images) VALUES
(N'Hoa tai 1', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/earrings/earrings_1.webp'),
(N'Hoa tai 2', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/earrings/earrings_2.webp'),
(N'Hoa tai 3', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/earrings/earrings_3.webp'),
(N'Hoa tai 4', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/earrings/earrings_4.webp'),
(N'Hoa tai 5', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/earrings/earrings_5.webp'),
(N'Hoa tai 6', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/earrings/earrings_6.webp'),
(N'Hoa tai 7', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 30, 'images/products/earrings/earrings_7.webp'),
(N'Hoa tai 8', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 40, 'images/products/earrings/earrings_8.webp'),
(N'Hoa tai 9', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/earrings/earrings_9.webp'),
(N'Hoa tai 10', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/earrings/earrings_10.webp'),
(N'Hoa tai 11', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/earrings/earrings_11.webp'),
(N'Hoa tai 12', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 50, 'images/products/earrings/earrings_12.webp'),
(N'Hoa tai 13', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/earrings/earrings_13.webp'),
(N'Hoa tai 14', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/earrings/earrings_14.webp'),
(N'Hoa tai 15', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/earrings/earrings_15.webp'),
(N'Hoa tai 16', 1, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/earrings/earrings_16.webp'),

(N'Lắc tay 1', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_1.webp'),
(N'Lắc tay 2', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_2.webp'),
(N'Lắc tay 3', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/bracelet/bracelet_3.webp'),
(N'Lắc tay 4', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/bracelet/bracelet_4.webp'),
(N'Lắc tay 5', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_5.webp'),
(N'Lắc tay 6', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_6.webp'),
(N'Lắc tay 7', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 30,'images/products/bracelet/bracelet_7.webp'),
(N'Lắc tay 8', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/bracelet/bracelet_8.webp'),
(N'Lắc tay 9', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 40, 'images/products/bracelet/bracelet_9.webp'),
(N'Lắc tay 10', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_10.webp'),
(N'Lắc tay 11', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/bracelet/bracelet_11.webp'),
(N'Lắc tay 12', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/bracelet/bracelet_12.webp'),
(N'Lắc tay 13', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_13.webp'),
(N'Lắc tay 14', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 50, 'images/products/bracelet/bracelet_14.webp'),
(N'Lắc tay 15', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_15.webp'),
(N'Lắc tay 16', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/bracelet/bracelet_16.webp'),
(N'Lắc tay 17', 2, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/bracelet/bracelet_17.webp'),

(N'Dây chuyền 1', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_1.webp'),
(N'Dây chuyền 2', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_2.webp'),
(N'Dây chuyền 3', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/necklace/necklace_3.webp'),
(N'Dây chuyền 4', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_4.webp'),
(N'Dây chuyền 5', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/necklace/necklace_5.webp'),
(N'Dây chuyền 6', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/necklace/necklace_6.webp'),
(N'Dây chuyền 7', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_7.webp'),
(N'Dây chuyền 8', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 30, 'images/products/necklace/necklace_8.webp'),
(N'Dây chuyền 9', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/necklace/necklace_9.webp'),
(N'Dây chuyền 10', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_10.webp'),
(N'Dây chuyền 11', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_11.webp'),
(N'Dây chuyền 12', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 40, 'images/products/necklace/necklace_12.webp'),
(N'Dây chuyền 13', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_13.webp'),
(N'Dây chuyền 14', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_14.webp'),
(N'Dây chuyền 15', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 50, 'images/products/necklace/necklace_15.webp'),
(N'Dây chuyền 16', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/necklace/necklace_16.webp'),
(N'Dây chuyền 17', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/necklace/necklace_17.webp'),
(N'Dây chuyền 18', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_18.webp'),
(N'Dây chuyền 19', 3, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/necklace/necklace_19.webp'),

(N'Nhẫn 1', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/rings/rings_1.webp'),
(N'Nhẫn 2', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/rings/rings_2.webp'),
(N'Nhẫn 3', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/rings/rings_3.webp'),
(N'Nhẫn 4', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/rings/rings_4.webp'),
(N'Nhẫn 5', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/rings/rings_5.webp'),
(N'Nhẫn 6', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 30, 'images/products/rings/rings_6.webp'),
(N'Nhẫn 7', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/rings/rings_7.webp'),
(N'Nhẫn 8', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 40, 'images/products/rings/rings_8.webp'),
(N'Nhẫn 9', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/rings/rings_9.webp'),
(N'Nhẫn 10', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/rings/rings_10.webp'),
(N'Nhẫn 11', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 10, 'images/products/rings/rings_11.webp'),
(N'Nhẫn 12', 4, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/rings/rings_12.webp'),

(N'Lắc chân 1', 5, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 50, 'images/products/anklet/anklet_1.webp'),
(N'Lắc chân 2', 5, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 20, 'images/products/anklet/anklet_2.webp'),
(N'Lắc chân 3', 5, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/anklet/anklet_3.webp'),
(N'Lắc chân 4', 5, ROUND(RAND() * 100, 0), ROUND(ROUND(RAND() * 500000 + 750000, 0) / 10000, 0) * 10000, 0, 'images/products/anklet/anklet_4.webp')


--insert into Reviews(ProductID, UserID, Rating)
--VALUES
--(1, 95, 4), 
--(1, 20, 4), 
--(1, 23, 5), 
--(1, 76, 3), 
--(1, 90, 3), 
--(2, 73, 4), 
--(2, 67, 5), 
--(2, 76, 1), 
--(2, 8, 4), 
--(2, 54, 5), 
--(3, 77, 3), 
--(3, 68, 3), 
--(3, 13, 4), 
--(3, 25, 2), 
--(3, 8, 3), 
--(4, 71, 3), 
--(4, 92, 2), 
--(4, 37, 2), 
--(4, 49, 1), 
--(4, 16, 1), 
--(5, 62, 2), 
--(5, 69, 5), 
--(5, 53, 2), 
--(5, 16, 2), 
--(5, 64, 5), 
--(6, 80, 4), 
--(6, 88, 2), 
--(6, 84, 5), 
--(6, 30, 5), 
--(6, 52, 4), 
--(7, 35, 3), 
--(7, 56, 1), 
--(7, 49, 1), 
--(7, 9, 3), 
--(7, 18, 5), 
--(8, 13, 2), 
--(8, 62, 1), 
--(8, 65, 3), 
--(8, 58, 5), 
--(8, 98, 3), 
--(9, 2, 1), 
--(9, 19, 2), 
--(9, 9, 2), 
--(9, 92, 2), 
--(9, 78, 4), 
--(10, 37, 4), 
--(10, 29, 3), 
--(10, 53, 1), 
--(10, 12, 3), 
--(10, 83, 2), 
--(11, 56, 4), 
--(11, 43, 3), 
--(11, 12, 1), 
--(11, 23, 4), 
--(11, 97, 2), 
--(12, 79, 4), 
--(12, 90, 1), 
--(12, 74, 5), 
--(12, 38, 2), 
--(12, 22, 4), 
--(13, 43, 4), 
--(13, 70, 2), 
--(13, 76, 1), 
--(13, 34, 3), 
--(13, 19, 5), 
--(14, 64, 2), 
--(14, 41, 1), 
--(14, 52, 5), 
--(14, 33, 4), 
--(14, 18, 1), 
--(15, 73, 4), 
--(15, 3, 4), 
--(15, 79, 4), 
--(15, 86, 3), 
--(15, 18, 5), 
--(16, 100, 2), 
--(16, 43, 4), 
--(16, 96, 1), 
--(16, 3, 5), 
--(16, 58, 3), 
--(17, 56, 1), 
--(17, 63, 1), 
--(17, 7, 4), 
--(17, 66, 5), 
--(17, 21, 5), 
--(18, 74, 3), 
--(18, 92, 2), 
--(18, 95, 1), 
--(18, 94, 3), 
--(18, 38, 1), 
--(19, 77, 5), 
--(19, 54, 3),  
--(19, 3, 1), 
--(19, 43, 3), 
--(20, 95, 4), 
--(20, 74, 3), 
--(20, 44, 3), 
--(20, 20, 4), 
--(20, 77, 2),  
--(21, 36, 4), 
--(21, 44, 3), 
--(21, 32, 1), 
--(21, 42, 4), 
--(22, 15, 5), 
--(22, 34, 4), 
--(22, 28, 4), 
--(22, 77, 5), 
--(22, 51, 2), 
--(23, 73, 5), 
--(23, 24, 5), 
--(23, 98, 3), 
--(23, 6, 1), 
--(23, 2, 3), 
--(24, 76, 2), 
--(24, 62, 4), 
--(24, 10, 5), 
--(24, 78, 4), 
--(24, 45, 4), 
--(25, 57, 2), 
--(25, 56, 1), 
--(25, 4, 4), 
--(25, 69, 4), 
--(25, 35, 3), 
--(26, 9, 5), 
--(26, 44, 1), 
--(26, 48, 4), 
--(26, 28, 5), 
--(26, 72, 2), 
--(27, 40, 2), 
--(27, 31, 1), 
--(27, 79, 1), 
--(27, 39, 3), 
--(27, 1, 3), 
--(28, 88, 4), 
--(28, 67, 2), 
--(28, 9, 2), 
--(28, 2, 4), 
--(28, 54, 5), 
--(29, 10, 2), 
--(29, 9, 5), 
--(29, 62, 3), 
--(29, 1, 5), 
--(29, 88, 4), 
--(30, 63, 4), 
--(30, 61, 4), 
--(30, 49, 1), 
--(30, 74, 5), 
--(30, 27, 2), 
--(31, 78, 4), 
--(31, 52, 2), 
--(31, 49, 4),  
--(31, 81, 4), 
--(32, 57, 1), 
--(32, 65, 1), 
--(32, 10, 1), 
--(32, 74, 3), 
--(32, 19, 2), 
--(33, 33, 1), 
--(33, 9, 4), 
--(33, 45, 5), 
--(33, 87, 5), 
--(33, 83, 1), 
--(34, 53, 1), 
--(34, 35, 1), 
--(34, 13, 1), 
--(34, 4, 2), 
--(34, 3, 3), 
--(35, 98, 2), 
--(35, 46, 5), 
--(35, 56, 1), 
--(35, 53, 1), 
--(35, 55, 1), 
--(36, 35, 4), 
--(36, 62, 4), 
--(36, 99, 3), 
--(36, 72, 1), 
--(36, 68, 3), 
--(37, 99, 1), 
--(37, 25, 4), 
--(37, 62, 1), 
--(37, 58, 5), 
--(37, 26, 2), 
--(38, 39, 5), 
--(38, 100, 4), 
--(38, 97, 2), 
--(38, 26, 1), 
--(38, 16, 2), 
--(39, 31, 2), 
--(39, 85, 2), 
--(39, 70, 3), 
--(39, 88, 3), 
--(39, 18, 5), 
--(40, 19, 1), 
--(40, 64, 4), 
--(40, 100, 4), 
--(40, 5, 1), 
--(40, 89, 5), 
--(41, 68, 4), 
--(41, 39, 3), 
--(41, 74, 2), 
--(41, 34, 2), 
--(41, 32, 3), 
--(42, 14, 4), 
--(42, 15, 4), 
--(42, 35, 2), 
--(42, 6, 3), 
--(42, 39, 4), 
--(43, 18, 2), 
--(43, 38, 5), 
--(43, 94, 2), 
--(43, 86, 2), 
--(44, 36, 2), 
--(44, 39, 3), 
--(44, 1, 4), 
--(44, 38, 5), 
--(44, 98, 5), 
--(45, 36, 1), 
--(45, 67, 5), 
--(45, 70, 3), 
--(45, 92, 1), 
--(45, 94, 4), 
--(46, 9, 5), 
--(46, 1, 5), 
--(46, 96, 3), 
--(46, 15, 2), 
--(46, 83, 5), 
--(47, 99, 4), 
--(47, 75, 3), 
--(47, 40, 1), 
--(47, 16, 3), 
--(47, 58, 1), 
--(48, 56, 1), 
--(48, 42, 2), 
--(48, 88, 5), 
--(48, 92, 1), 
--(49, 33, 1), 
--(49, 68, 5), 
--(49, 45, 1), 
--(49, 22, 1), 
--(49, 65, 1), 
--(50, 76, 2), 
--(50, 14, 1), 
--(50, 1, 3), 
--(50, 80, 3), 
--(50, 48, 5), 
--(51, 100, 1), 
--(51, 24, 1), 
--(51, 98, 1), 
--(51, 67, 5), 
--(51, 4, 5), 
--(52, 85, 1), 
--(52, 76, 2), 
--(52, 79, 5), 
--(52, 97, 2), 
--(52, 68, 4), 
--(53, 53, 4), 
--(53, 31, 2), 
--(53, 83, 3), 
--(53, 5, 5), 
--(53, 71, 5), 
--(54, 86, 1), 
--(54, 85, 2), 
--(54, 15, 4), 
--(54, 44, 2), 
--(54, 20, 3), 
--(55, 72, 2), 
--(55, 78, 4), 
--(55, 36, 5), 
--(55, 70, 2), 
--(55, 54, 1), 
--(56, 42, 3), 
--(56, 73, 4), 
--(56, 43, 5), 
--(56, 34, 4), 
--(56, 1, 2), 
--(57, 31, 2), 
--(57, 12, 2), 
--(57, 6, 5), 
--(57, 60, 2), 
--(57, 97, 3), 
--(58, 23, 2), 
--(58, 29, 5), 
--(58, 63, 2), 
--(58, 27, 2), 
--(59, 57, 1),  
--(59, 32, 5), 
--(59, 43, 2), 
--(59, 74, 1), 
--(60, 75, 1), 
--(60, 69, 4), 
--(60, 36, 5), 
--(60, 47, 2), 
--(60, 29, 3), 
--(61, 5, 1),  
--(61, 17, 2), 
--(61, 28, 5), 
--(61, 59, 1), 
--(62, 80, 3), 
--(62, 66, 1), 
--(62, 92, 2), 
--(62, 30, 1), 
--(62, 62, 1), 
--(63, 58, 2), 
--(63, 36, 4), 
--(63, 92, 5), 
--(63, 16, 2), 
--(63, 51, 2), 
--(64, 100, 5), 
--(64, 90, 3), 
--(64, 36, 4), 
--(64, 39, 1), 
--(64, 57, 1), 
--(65, 14, 1), 
--(65, 39, 3), 
--(65, 67, 5), 
--(65, 37, 3), 
--(65, 18, 1), 
--(66, 41, 1), 
--(66, 80, 4), 
--(66, 82, 4), 
--(66, 49, 3),  
--(67, 34, 2), 
--(67, 94, 5), 
--(67, 50, 4), 
--(67, 84, 3), 
--(67, 9, 5), 
--(68, 39, 3), 
--(68, 36, 1), 
--(68, 33, 5), 
--(68, 49, 2), 
--(68, 40, 1)

