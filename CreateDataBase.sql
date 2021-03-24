-------------------------------------------------------------------------------------
--313548810
-------------------------------------------------------------------------------------
--CREATE TABLES
--------------------------------------------------

--Suppliers table
CREATE TABLE  IF NOT EXISTS Suppliers (
	Supplier_id INTEGER PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	contact_phone_number INTEGER NOT NULL,
	CONSTRAINT CHECK_NAME_20 CHECK (length(name)<=20)
);
--Delivery company table
CREATE TABLE IF NOT EXISTS Delivery_Company (
	company_id INTEGER PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	contact_phone_number INTEGER NOT NULL
	CONSTRAINT CHECK_NAME_20 CHECK (length(name)<=20)
);

--Custumers table
CREATE TABLE IF NOT EXISTS Custumers (
	Custumer_id INTEGER PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	address VARCHAR(100) NOT NULL,
	phone_number INTEGER NOT NULL,
	CONSTRAINT CHECK_FIRST_NAME CHECK (length(first_name)<=50),
	CONSTRAINT CHECK_LAST_NAME CHECK (length(last_name)<=50)
);
-- Products table
CREATE TABLE IF NOT EXISTS Products (
	Product_id INTEGER PRIMARY KEY,
	Product_name VARCHAR(20) NOT NULL,
	Description VARCHAR(200),
	price INTEGER NOT NULL,
	number_in_stock INTEGER NOT NULL,
	Supplier_id INTEGER NOT NULL,
	Componnent_id INTEGER DEFAULT NULL REFERENCES Products(Product_id),
	CONSTRAINT CHECK_PROD_NAME_20 CHECK (length(Product_name)<=20),
	CONSTRAINT CHECK_Descrip CHECK (length(Description)<=200),
	FOREIGN KEY (Supplier_id) REFERENCES Suppliers(Supplier_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
--Review table
CREATE TABLE IF NOT EXISTS Reviews (
	Review_id INTEGER PRIMARY KEY,
	description VARCHAR(200),
	stars INTEGER NOT NULL,
	Custumer_id INTEGER NOT NULL,
	Product_id INTEGER NOT NULL,
	CONSTRAINT CHECK_STARS CHECK ((stars<=5) AND (stars>=1)),
	CONSTRAINT CHECK_Descrip CHECK (length(Description)<=200),
	FOREIGN KEY (Custumer_id) REFERENCES Custumers(Custumer_id) 
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
--Orders table
CREATE TABLE IF NOT EXISTS Orders (
	Order_num INTEGER PRIMARY KEY,
	date DATE NOT NULL,
	Custumer_id INTEGER NOT NULL,
	FOREIGN KEY (Custumer_id) REFERENCES Custumers(Custumer_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
-- Products  per order table
CREATE TABLE IF NOT EXISTS Products_per_Order (
	Order_num INTEGER NOT NULL,
	Product_id INTEGER NOT NULL,
	amount INTEGER NOT NULL,
	price_per_unit INTEGER NOT NULL,
	FOREIGN KEY (Order_num) REFERENCES Orders(Order_num)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);

--Shipments table
 CREATE TABLE IF NOT EXISTS Shipments (
	Shipment_id INTEGER PRIMARY KEY,
	Shipment_method VARCHAR(20), 
	Order_num INTEGER NOT NULL,
	date DATE NOT NULL,
	Custumer_id INTEGER NOT NULL,
	Delivery_company_id INTEGER NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL ,
	address VARCHAR(200) NOT NULL ,
	phone INTEGER NOT NULL,
	FOREIGN KEY (Delivery_company_id) REFERENCES delivery_company(company_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Custumer_id) REFERENCES Custumers(Custumer_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Order_num) REFERENCES Orders(Order_num)
		ON DELETE CASCADE ON UPDATE CASCADE
 );


--Payment table
CREATE TABLE IF NOT EXISTS Payments (
	Payment_id INTEGER PRIMARY KEY,
	Order_num INTEGER NOT NULL,
	Custumer_id INTEGER NOT NULL,
	amount INTEGER NOT NULL,
	credit_card VARCHAR(16) NOT NULL,
	FOREIGN KEY (Order_num) REFERENCES Orders(Order_num)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Custumer_id) REFERENCES Custumers(Custumer_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
---INSERT DATA TO TABLES
-----------------------------------------------------------------------------
INSERT INTO Custumers
VALUES (123456789,'Daniel','kohav','mivtza ovda 1 beer sheva',0523456754),
	    (205139781,'Einav','Cohen','kalanit 5 maale adomim',0529874321),
	    (310281083,'Liel','Katorza','mivtza Nahshon 12 beer sheva',0534247654),
		(313548810,'Dana','Nehemia','Mesada 140 beer sheva',0522801472),
		(343273192,'Daniel','ventura','kedem 122 shoham',0527896543),
		(210340654,'Omri','Oshrovitz','yasmin 53 modiin',0545679086),
		(143568197,'Lital','Malka','rotshild 25 tel aviv',0547653256),
		(157893712,'Doron','Perez','Gdalyahu 8 haifa',0587654123),
		(456123789,'Mai','Eliyahu','Meshek 23 Givat koah',0547652345),
		(987654321,'Vered','Valensky','mesada 31 beer sheva',0526780942),
		(807523179,'Nurit','Yampulsky','yitzhak katzanelson 15 netanya',0534567120),
		(905321879,'Shira','Michael','chita 1 mitzpe ramon',0524567098),
		(814342205,'Dana','Golan','nurit 31 modiin',0589065435),
		(999999999,'Razi','Udi','mitzpe 61 shoham',0544556677),
		(888888888,'Tair','Oren','mitzpe 1 shoham',0548097654),
		(777777777,'Tal','Livnat','ben yehuda 8 nahariya',0548907652),
		(555555551,'sara','Eliyahu','yaakov cohen 65 yerushalaim',0520987652),
		(444444444,'Ortal','SAROYA','hertzel 63 ashdod',0538765423);
		

INSERT INTO Suppliers
VALUES(1,'Dana Nehemia',0522801472),
		(2,'noy lifshitz',0536567895),
		(3,'piece of craft',0534688765),
		(4,'matan tree',0523457865),
		(5,'teddys wool',0523456765);

INSERT INTO Products
VALUES (1,'Degem Butterfly','1.5 meter x 1 meter',450,3,1,9),
		(2,'Degem Ron','80 cm x 1 meter',350,5,1,8),
		(3,'Degem Yahel','1 meter x 1 meter',400,4,1,10),
		(4,'Degem Aviv','30 cm x 60 cm',150,10,1,8),
		(5,'Macrame bag','veraity of colors',200,8,1,9),
		(6,'Triccot Bag','veraity of colors',180,10,1,NULL),
		(7,'DIY Kit','makr your own piece',120,15,1,8),
		(8,'Macrame String','twisted string 5 mm',30,8,2,14),
		(9,'Single twist string','single twist 3 mm',30,10,3,13),
		(10,'1 meter branch','1 meter,clean branch',60,7,4,NULL),
		(11,'80 cm branch','80 cm clean branch',30,3,4,NULL),
		(13,'macrame type','3mm',2,3,1,NULL),
		(14,'macrame type','5mm',2,3,1,NULL);
		
INSERT INTO Orders
VALUES (1,'2020-04-17',205139781),
		(2,'2020-05-02',310281083),
		(3,'2020-05-19',343273192),
		(4,'2020-06-04',210340654 ),
		(5,'2020-07-07',157893712),
		(6,'2020-07-21',143568197),
		(7,'2020-08-14',456123789),
		(8,'2020-09-29',987654321),
		(9,'2020-10-27',807523179),
		(10,'2020-10-27',905321879),
		(11,'2020-10-27',814342205),
		(12,'2020-10-31',999999999),
		(13,'2021-01-17',888888888),
		(14,'2021-01-29',777777777),
		(15,'2021-02-03',555555551),
		(16,'2021-02-05',444444444),
		(17,'2021-02-07',123456789),
		(18,'2021-02-03',313548810),
		(19,'2020-10-27',313548810),
		(20,'2020-04-17',313548810);
		
INSERT INTO Payments 
VALUES (1,1,205139781,400,5326102356789854),
		(2,2,310281083,350,5326102376543210),
		(3,3,343273192,270,4580130987652345),
		(4,4,210340654,150,4580987612345678),
		(5,5,157893712,200,5326890675431234),
		(6,6,143568197,180,5436789012345637),
		(7,7,456123789,90,6542345098767689),
		(8,8,987654321,210,5436789765134268),
		(9,9,807523179,450,5328790765435627),
		(10,10,905321879,380,5436789065426516),
		(11,11,814342205,240,7890654326780987),
		(12,12,999999999,520,9876543676508464),
		(13,13,888888888,350,8706354769375950),
		(14,14,777777777,600,3758498465769707),
		(15,15,555555551,450,8607315776869690),
		(16,16,444444444,200,5676879473537585),
		(17,17,123456789,360,6879575648586869),
		(18,18,313548810,270,9867455769696878),
		(19,19,313548810,360,9867455769696878),
		(20,20,313548810,180,9867455769696878);
		
INSERT INTO products_per_order
VALUES  (1,3,1,400),
		(2,2,1,500),
		(3,4,1,150),
		(3,7,1,120),
		(4,4,1,150),
		(5,5,1,200),
		(6,6,1,180),
		(7,8,3,30),
		(8,9,7,30),
		(9,1,1,450),
		(10,5,1,200),
		(10,6,1,180),
		(11,10,2,60),
		(11,9,4,30),
		(12,3,1,400),
		(12,11,4,30),
		(13,2,1,350),
		(14,3,1,400),
		(14,5,1,200),
		(15,1,1,450),
		(16,5,1,200),
		(17,4,2,150),
		(17,10,1,60),
		(18,8,9,30),
		(19,9,12,30),
		(20,9,6,30);
		
INSERT INTO Delivery_Company
VALUES(1,'ISRAEL POST',0529876577),
		(2,'CHEETA',0536567995),
		(3,'UPS',0534688885)
		(4,PickUp,0);
		
INSERT INTO Shipments
VALUES (1,'HomeDelivery',1,'2020-04-19',205139781,1,'Einav','Cohen','kalanit 5 maale adomim',0529874321),
		(2,'PickUp',2,'2020-05-04',310281083,4,'Liel','Katorza','mivtza Nahshon 12 beer sheva',0534247654),
		(3,'PickUp',3,'2020-05-19',343273192,4,'Daniel','ventura','kedem 122 shoham',0527896543),
		(4,'PickUp_Point',4,'2020-06-06',210340654,4,'Omri','Oshrovitz','yasmin 53 modiin',0545679086 ),
		(5,'HomeDelivery',5,'2020-07-09',157893712,1,'Doron','Perez','Gdalyahu 8 haifa',0587654123),
		(6,'HomeDelivery',6,'2020-07-23',143568197,1,'Lital','Malka','rotshild 25 tel aviv',0547653256),
		(7,'PickUp',7,'2020-08-16',456123789,4,'Mai','Eliyahu','Meshek 23 Givat koah',0547652345),
		(8,'PickUp',8,'2020-09-30',987654321,4,'Vered','Valensky','mesada 31 beer sheva',0526780942),
		(9,'PickUp_Point',9,'2020-10-27',807523179,3,'Nurit','Yampulsky','yitzhak katzanelson 15 netanya',0534567120),
		(10,'HomeDelivery',10,'2020-10-27',905321879,2,'Shira','Michael','chita 1 mitzpe ramon',0524567098),
		(11,'PickUp_Point',11,'2020-10-27',814342205,3,'Dana','Golan','nurit 31 modiin',0589065435),
		(12,'PickUp',12,'2020-10-31',999999999,4,'Razi','Udi','mitzpe 61 shoham',0544556677),
		(13,'PickUp',13,'2021-01-19',888888888,4,'Tair','Oren','mitzpe 1 shoham',0548097654),
		(14,'HomeDelivery',14,'2021-01-29',777777777,3,'Tal','Livnat','ben yehuda 8 nahariya',0548907652),
		(15,'HomeDelivery',15,'2021-02-03',555555551,3,'sara','Eliyahu','yaakov cohen 65 yerushalaim',0520987652),
		(16,'PickUp_Point',16,'2021-02-05',444444444,2,'Ortal','SAROYA','hertzel 63 ashdod',0538765423),
		(17,'PickUp',16,'2021-02-07',123456789,4,'Daniel','kohav','mivtza ovda 1 beer sheva',0523456754),
		(18,'HomeDelivery',18,'2021-02-03',313548810,3,'Dana','Nehemia','Mesada 140 beer sheva',0522801472),
		(19,'HomeDelivery',19,'2020-10-27',313548810,2,'Dana','Nehemia','Mesada 140 beer sheva',0522801472),
		(20,'HomeDelivery',20,'2020-04-17',313548810,2,'Dana','Nehemia','Mesada 140 beer sheva',0522801472);
		

		
INSERT INTO Reviews
VALUES(1,'beautiful and large',5,205139781,3),
		(2,'the piece is beautiful',5,310281083,2),
		(3,'love it',4,343273192,4),
		(4,'amazing',4,210340654,4),
		(5,'very good',5,157893712,5),
		(6,'good quality',5,143568197,6),
		(7,'beautiful',5,456123789,8),
		(8,'very good',4,987654321,9),
		(9,'good',4,807523179,1),
		(10,'great',5,905321879,5),
		(11,'very beautiful',5,814342205,10),
		(12,'love it',5,999999999,11);
		
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--QUERIES
---------------------------------------------------------------------------
--A.show invoices for each order
SELECT Orders.order_num,Orders.date,Custumers.custumer_id,Custumers.first_name,Custumers.last_name,Payments.amount
FROM Orders
INNER JOIN Custumers ON Orders.Custumer_id = Custumers.Custumer_id
INNER JOIN Payments ON Orders.Order_num = Payments.Order_num

--B.show custumers who ordered this month
SELECT Custumers.first_Name,Custumers.last_name, Orders.Order_num
FROM Custumers
FULL OUTER JOIN Orders ON Custumers.Custumer_id=Orders.Custumer_id
WHERE Orders.date > '2021-01-31' AND Orders.date < '2021-03-01'

--C.show all custumers id that ordered on July 2020 and wrote a review with 5 strars
SELECT Custumer_id  FROM Reviews
WHERE Reviews.stars = 5 
INTERSECT
SELECT Custumer_id FROM Orders
WHERE Orders.date < '2020-08-01' AND Orders.date > '2020-06-30'
ORDER BY Custumer_id;

--D. show the product that costs more than 300 and was ordered at least 3 times
SELECT Products_per_order.product_id
FROM Products_per_order
WHERE Products_per_order.price_per_unit >= 300
GROUP BY Products_per_order.product_id
HAVING  COUNT(Products_per_order.product_id ) >= 3;

--E.show the names of all the product ordered by custumer id - 343273192
SELECT Products.Product_name
FROM Products
WHERE Products.product_id = ANY(
SELECT ALL(Products_per_order.Product_id)
FROM Products_per_order
WHERE Products_per_order.Order_num= ALL(
SELECT Orders.order_num
FROM Orders
WHERE Orders.custumer_id = 343273192));

--F.show the products that wasnt sold this year
SELECT DISTINCT Products.Product_id
FROM   Products,Orders,Products_per_order
WHERE  Products.Product_id NOT IN 
(SELECT Products_per_order.product_id
 FROM  Orders,Products_per_order
 WHERE Orders.order_num = Products_per_order.order_num  
 AND Orders.date > '2020-12-31');
----------------------------------------------
--in order for query g to return value you need to use this
---UPDATE Products
---SET Supplier_id = 1
---WHERE Supplier_id <> 1
------------------------------------------------
--G.all Suplliers that supply all Products
SELECT Suppliers.name FROM suppliers
WHERE NOT EXISTS (( SELECT Products.Product_id FROM Products )
EXCEPT
 (SELECT Products.product_id FROM Products WHERE Products.supplier_id = Suppliers.supplier_id ) );

--H. show all the components of product_id = 1
WITH RECURSIVE Ansentor(Product_id,Componnent_id) AS
((SELECT Product_id, Componnent_id FROM Products )
UNION 
(SELECT a1.Product_id,a2.Componnent_id FROM Ansentor a1 ,
 (SELECT Product_id,Componnent_id FROM Products) a2
WHERE a1.componnent_id = a2.product_id))
SELECT Componnent_id
FROM Ansentor
WHERE Product_id= 1;

--I.show incomes vs outcomes
SELECT  
       SUM(case when Payments.Custumer_id <> 313548810 then Payments.amount end) as incomes,
       SUM(case when Payments.Custumer_id = 313548810 then Payments.amount end) as outcomes
FROM Payments ;

--J. shows the custumer who made the most expensive order
SELECT Orders.custumer_id
FROM Orders
WHERE Orders.order_num = (
SELECT Payments.order_num
FROM Payments
WHERE Payments.amount = (SELECT MAX(Payments.amount) FROM Payments));

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--14.LAG\LEAD
---------------------------------------------------------------------------
SELECT order_num,custumer_id,date, LAG(Orders.Order_num,1) 
over (PARTITION BY custumer_id ORDER BY date) AS prev_order
FROM ORDERS
------------------------------------------------
with new_table as (select order_num,custumer_id,date, 
	ROW_NUMBER() OVER (ORDER BY custumer_id,date) AS row_num FROM Orders)
SELECT a1.order_num,a1.date,a1.custumer_id,a2.order_num AS prev_order
FROM new_table AS a1
LEFT OUTER JOIN new_table as a2 ON a1.row_num - 1 = a2.row_num AND a1.custumer_id = a2.custumer_id

---------------------------------------------------------------------------
----------------------------------------------------------------------------
--15.Trigger
----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Update_Stock() 
RETURNS TRIGGER 
LANGUAGE PLPGSQL
AS $$
DECLARE

BEGIN
update Products
set Number_in_stock = Number_in_stock - New.amount
where Product_id = new.Product_id;
   
return new;
END;
$$;

CREATE TRIGGER Order_inserted AFTER INSERT ON Products_per_order
for each row EXECUTE FUNCTION Update_Stock();
------------------------------------------------------------------









	