-- Multi-Table Sorgu Pratiği

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)

SELECT
    p.ProductName,
    c.CategoryName
FROM
    Product as p
    join Category as c on c.Id = p.CategoryId;
-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)

SELECT
    o.Id as 'Sipariş Kodu',
    c.CompanyName as 'Şirket Adı'
FROM
    [Order] as o
    join Customer as c on c.Id = o.CustomerId
WHERE
    o.OrderDate < '2012-08-09';
-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)

SELECT
    Count(p.ProductName) as 'Ürün Sayısı'
FROM
    OrderDetail od
    join Product p on od.ProductId = p.Id
WHERE
    OrderId = 10251
ORDER BY
    p.ProductName;

-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)
SELECT
    o.Id,
    c.CompanyName,
    e.LastName
FROM
    [Order] as o
    join Customer as c on o.CustomerId = c.Id
    join Employee as e on e.Id = o.EmployeeId;

------------ ESNEK GÖREVLER ----------------------------
----- 1.Soru Her gönderici tarafından gönderilen gönderi sayısını bulun. ---
SELECT
    CustomerId,
    count(CustomerId) as 'SiparisSayisi'
FROM
    [Order]
GROUP BY
    CustomerId
ORDER BY
    count(CustomerId) desc;

------2.Soru Sipariş sayısına göre ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.-----------------
SELECT
    e.FirstName,
    e.LastName,
    Count(o.EmployeeId) as 'ToplamSiparisSayisi'
FROM
    [Order] o
    join Employee e on o.EmployeeId = e.Id
GROUP BY
    o.EmployeeId
ORDER BY
    Count(o.EmployeeId) desc
LIMIT
    5;

----- 3.Soru Gelir olarak ölçülen en iyi performans gösteren ilk 5 çalışanı bulun. ----

SELECT
    e.FirstName,
    e.LastName,
    Round(Sum(od.Quantity * od.UnitPrice *(1 - od.Discount)), 3) as 'ToplamSatisTutari'
FROM
    OrderDetail od
    join [Order] o on od.OrderId = o.Id
    join [Employee] e on o.EmployeeId = e.Id
GROUP BY
    o.EmployeeId
ORDER BY
    Sum(od.Quantity * od.UnitPrice) desc
LIMIT
    5;

----- 4.Soru En az gelir getiren kategoriyi bulun------------------
SELECT
    c.CategoryName,
    Round(Sum(od.Quantity * od.UnitPrice *(1 - od.Discount)), 3) as 'ToplamSatisTutari'
FROM
    OrderDetail od
    join [Order] o on od.OrderId = o.Id
    join [Product] p on od.ProductId = p.Id
    join Category c on c.Id = p.CategoryId
GROUP BY
    p.CategoryId
ORDER BY
    Sum(od.Quantity * od.UnitPrice)
LIMIT
    1;

---- 5.Soru En çok siparişi olan müşteri ülkesini bulun.-------
SELECT
    c.Country,
    count(c.Country) as 'SiparisSayisi'
FROM
    [Order] o
    join Customer c on o.CustomerId = c.Id
GROUP BY
    c.Country
ORDER BY
    count(c.Country) desc
LIMIT
    1;
    