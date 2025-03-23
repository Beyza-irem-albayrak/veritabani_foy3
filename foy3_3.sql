-- Sorgu 1 – Yazılım veya Donanım Birimlerdeki Çalışanların Listelenmesi 
SELECT ad, soyad, maas 
FROM calisanlar 
WHERE calisan_birim_id IN (SELECT birim_id FROM birimler WHERE birim_ad IN ('Yazılım', 'Donanım'));

--Sorgu 2 – En Yüksek Maaşlı Çalışanların Listelenmesi
SELECT ad, soyad, maas 
FROM calisanlar 
WHERE maas = (SELECT MAX(maas) FROM calisanlar);

--Sorgu 3 – Her Bir Birimdeki Çalışan Sayısının Listelenmesi
SELECT birim_ad, 
(SELECT COUNT(*) FROM calisanlar c WHERE c.calisan_birim_id = b.birim_id) AS calisan_sayisi
FROM birimler b;

--Sorgu 4 – Birden Fazla Çalışana Ait Olan Unvanların Sayısının Listelenmesi
SELECT unvan_calisan, COUNT(*) AS calisan_sayisi
FROM unvan
GROUP BY unvan_calisan
HAVING COUNT(*) > 1;

--Sorgu 5 – Belirli Maaş Aralığındaki Çalışanların Seçilmesi
SELECT ad, soyad, maas 
FROM calisanlar 
WHERE maas BETWEEN 50000 AND 100000;

--Sorgu 6 – İkramiye Alan Çalışanların Detaylı Bilgilerinin Getirilmesi 
SELECT c.ad, c.soyad, b.birim_ad, u.unvan_calisan, i.ikramiye_ucret
FROM ikramiye i
JOIN calisanlar c ON i.ikramiye_calisan_id = c.calisan_id
LEFT JOIN birimler b ON c.calisan_birim_id = b.birim_id
LEFT JOIN unvan u ON u.unvan_calisan_id = c.calisan_id;

--Sorgu 7 – Ünvanı “Yönetici” veya “Müdür” Olanların Listelenmesi
SELECT c.ad, c.soyad, u.unvan_calisan
FROM calisanlar c
JOIN unvan u ON c.calisan_id = u.unvan_calisan_id
WHERE u.unvan_calisan IN ('Yönetici', 'Müdür');

--Sorgu 8 – Her Bir Birimdeki En Yüksek Maaşlı Çalışanların Getirilmesi
SELECT ad, soyad, maas 
FROM calisanlar 
WHERE maas IN (SELECT MAX(maas) FROM calisanlar GROUP BY calisan_birim_id);
