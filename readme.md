# SQL Sorgu Alıştırmaları

Bu hafta SQL sorguları üzerine çalışıyorsunuz. Bugünkü alıştırmada sizin için hazırladığımız veritabanında aşağıda istediğimiz sonuçları elde etmenize yarayan SQL sorgularını oluşturacaksınız.

# Proje Kurulumu
Projeyi forklayın ve clonlayın. Tamamladığınızda da pushlayın.

## Kütüphane Bilgi Sistemi

Bu veritabanı, bir okulun kütüphanesinden öğrencilerin aldıkları kitapların bilgisini barındırmaktadır.

#Tablolar 
`ogrenci` tablosu öğrencilerin listesini tutar.
`islem` tablosu öğrencilerin kütüphaneden aldıkları kitapların bilgilerini tutar
`kitap` tablosu kütüphanedeki kitapların bilgisini tutar
`yazar` tablosu kitapların yazarları bilgisini tutar
`tur` tablosu kitapların türlerini tutar.

Tablo ilişiklerini görmek için [ktphn.png] dosyasına göz atın.

Yazdığınız sorguları buradan test edebilirsiniz: [https://ergineer.com/assets/materials/fkg36so5-kutuphanebilgisistemi-sql/]

# Görevler
Aşağıda istenilen sonuçlara ulaşabilmek için gerekli SQL sorgularını yazın.

1) Öğrencinin adını, soyadını ve kitap aldığı tarihleri listeleyin. 

    select o.ograd, o.ogrsoyad, i.atarih from ogrenci o, islem i 
    where o.ogrno = i.ogrno 
    order by i.atarih;

2) Fıkra ve hikaye türündeki kitapların adını ve türünü listeleyin. 

    select t.turadi, k.kitapadi from tur t, kitap k 
    where t.turno = k.turno 
    having (t.turadi) in ("Fıkra","Hikaye") 
    order by k.kitapadi;

3) 10B veya 10C sınıfındaki öğrencilerin numarasını, adını, soyadını ve okuduğu kitapları listeleyin. 

    select o.ogrno, o.ograd, o.ogrsoyad, k.kitapadi, o.sinif from ogrenci o, kitap k, islem i 
    where i.kitapno = k.kitapno and o.ogrno = i.ogrno and (o.sinif = "10B" or o.sinif = "10C");

4) Öğrencinin adını, soyadını ve kitap aldığı tarihleri listeleyin.

 	select o.ograd, o.ogrsoyad, i.atarih from ogrenci o
 	join islem i on o.ogrno = i.ogrno;

5) Fıkra ve hikaye türündeki kitapların adını ve türünü listeleyin.

 	select k.kitapadi, t.turadi from tur t
 	join kitap k on t.turno = k.turno
 	where (t.turadi) in ("Fıkra", "Hikaye");

6) 10B veya 10C sınıfındaki öğrencilerin numarasını, adını, soyadını ve okuduğu kitapları, öğrenci adına göre listeleyin.

 	select o.ogrno, o.ograd, o.ogrsoyad, k.kitapadi, o.sinif from ogrenci o
 	join islem i on o.ogrno = i.ogrno 
    join kitap k on i.kitapno = k.kitapno 
    where (o.sinif = "10B" or o.sinif = "10C")
 	order by o.ograd asc;

7) Kitap alan öğrencinin adı, soyadı, kitap aldığı tarih listelensin. Kitap almayan öğrencilerinde listede görünsün.

 	select o.ograd, o.ogrsoyad, i.atarih from ogrenci o
 	left join islem i on o.ogrno = i.ogrno;

8) Kitap almayan öğrencileri listeleyin.

 	select o.ograd, o.ogrsoyad, i.atarih from ogrenci o
 	left join islem i on o.ogrno = i.ogrno
 	where i.atarih is null;

9) Alınan kitapların kitap numarasını, adını ve kaç defa alındığını kitap numaralarına göre artan sırada listeleyiniz.

 	select i.kitapno, k.kitapadi, count(*) from islem i 
    left join kitap k on i.kitapno = k.kitapno
 	group by i.kitapno
 	order by k.kitapno;

10) Alınan kitapların kitap numarasını, adını kaç defa alındığını (alınmayan kitapların yanında 0 olsun) listeleyin.

	select i.kitapno, k.kitapadi, count(i.kitapno) from islem i 
    right join kitap k on i.kitapno = k.kitapno
	group by i.kitapno
	order by k.kitapno;

11) Öğrencilerin adı soyadı ve aldıkları kitabın adı listelensin.

	select o.ograd, o.ogrsoyad, k.kitapadi from ogrenci o
	join islem i on o.ogrno = i.ogrno 
    join kitap k on i.kitapno = k.kitapno;


12) Her öğrencinin adı, soyadı, kitabın adı, yazarın adı soyad ve kitabın türünü ve kitabın alındığı tarihi listeleyiniz. Kitap almayan öğrenciler de listede görünsün.

	select o.ograd, o.ogrsoyad, k.kitapadi, y.yazarad, y.yazarsoyad, t.turadi, i.atarih from ogrenci o
	left join islem i on o.ogrno = i.ogrno 
    left join kitap k on i.kitapno = k.kitapno 
    left join yazar y on k.yazarno = y.yazarno
	left join tur t on k.turno = t.turno;

13) 10A veya 10B sınıfındaki öğrencilerin adı soyadı ve okuduğu kitap sayısını getirin.

	select distinct o.ograd, o.ogrsoyad, k.kitapadi, o.sinif from ogrenci o
	join islem i on o.ogrno = i.ogrno 
    join kitap k on i.kitapno = k.kitapno 
    where (o.sinif = "10A" or o.sinif = "10B");

14) Tüm kitapların ortalama sayfa sayısını bulunuz.

	select avg(k.sayfasayisi), k.kitapadi from kitap k
	group by k.kitapadi;

15) Sayfa sayısı ortalama sayfanın üzerindeki kitapları listeleyin.

	select k.sayfasayisi, k.kitapadi from kitap k
	where k.sayfasayisi > (select avg(sayfasayisi) from kitap);

16) Öğrenci tablosundaki öğrenci sayısını gösterin

	select count(ogrno) from ogrenci o;

17) Öğrenci tablosundaki toplam öğrenci sayısını toplam sayı takma(alias kullanımı) adı ile listeleyin.

	select count(ogrno) as 'Öğrenci Sayisi' from ogrenci;

18) Öğrenci tablosunda kaç farklı isimde öğrenci olduğunu listeleyiniz.

	select count(distinct ograd) from ogrenci o;

19) En fazla sayfa sayısı olan kitabın sayfa sayısını listeleyiniz.

	select k.sayfasayisi from kitap k 
    order by k.sayfasayisi desc 
    limit 1;

20) En fazla sayfası olan kitabın adını ve sayfa sayısını listeleyiniz.

	select k.sayfasayisi, k.kitapadi from kitap k 
    order by k.sayfasayisi desc 
    limit 1;

21) En az sayfa sayısı olan kitabın sayfa sayısını listeleyiniz.

	select k.sayfasayisi from kitap k 
    order by k.sayfasayisi asc 
    limit 1;

22) En az sayfası olan kitabın adını ve sayfa sayısını listeleyiniz.

	select k.sayfasayisi, k.kitapadi from kitap k 
    order by k.sayfasayisi asc 
    limit 1;

23) Dram türündeki en fazla sayfası olan kitabın sayfa sayısını bulunuz.

	select k.sayfasayisi, k.kitapadi, t.turadi from kitap k, tur t
	where t.turadi = "Dram" 
    order by k.sayfasayisi desc 
    limit 1;

24) numarası 15 olan öğrencinin okuduğu toplam sayfa sayısını bulunuz.

	select o.ograd, o.ogrsoyad, sum(k.sayfasayisi) from ogrenci o
	join islem i on o.ogrno = i.ogrno 
    join kitap k on i.kitapno = k.kitapno 
    where o.ogrno = 15;

25) İsme göre öğrenci sayılarının adedini bulunuz. (Örn: ali 5 tane, ahmet 8 tane)

	select ograd, count(*) from ogrenci o 
    group by ograd;

26) Her sınıftaki öğrenci sayısını bulunuz.

	select sinif, count(*) from ogrenci o 
    group by sinif;

27) Her sınıftaki erkek ve kız öğrenci sayısını bulunuz.

	select sinif, cinsiyet, count(*) from ogrenci o 
    group by sinif, cinsiyet;

28) Her öğrencinin adını, soyadını ve okuduğu toplam sayfa sayısını büyükten küçüğe doğru listeleyiniz.

	select  o.ograd, o.ogrsoyad, sum(k.sayfasayisi) from ogrenci o
	join islem i on o.ogrno = i.ogrno 
    join kitap k on i.kitapno = k.kitapno 
    group by k.sayfasayisi
	order by k.sayfasayisi desc;

29) Her öğrencinin okuduğu kitap sayısını getiriniz.

	select o.ograd, o.ogrsoyad, count(o.ogrno) from ogrenci o
	left join islem i on o.ogrno = i.ogrno
	left join kitap k on i.kitapno = k.kitapno 
    group by o.ogrno;
