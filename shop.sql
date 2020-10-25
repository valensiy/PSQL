--1. Создать базу данных shop.

CREATE ROLE shop LOGIN CREATEDB PASSWORD 'shop';

--2. Создать юзера shop и дать ему полный доступ к БД shop.

CREATE DATABASE shop WITH OWNER=shop ENCODING='UTF8';

--4. Создать таблицу для хранения категорий (хранить название).

CREATE TABLE "category" (
	category_id SERIAL PRIMARY KEY NOT NULL,
    category_title VARCHAR(100) NOT NULL
);

--5. Добавить несколько категорий.

INSERT INTO "category" (category_title) VALUES ('kettles'), ('irons'), ('vacuum cleaners');

--6. Создать таблицу для хранения товаров (название, категория, цена).

CREATE TABLE "item" (
	item_id SERIAL PRIMARY KEY NOT NULL,
    category_id INTEGER NOT NULL REFERENCES "category" (category_id) ON DELETE SET NULL,
    item_title VARCHAR(100) NOT NULL,
    item_price NUMERIC(8, 2) NOT NULL DEFAULT 1.00
);

--7. Внести несколько товаров по цене 1.00

INSERT INTO "item" (category_id, item_title) VALUES
(1, 'philips'), (1, 'tefal'),
(2, 'braun'), (2, 'bosch'),
(3, 'delonghi');

--8. Обновить цену первого товара — 3.50

UPDATE "item" SET item_price = 3.5 WHERE item_id = 1;

--9. Увеличить цену всех товаров на 10%.
UPDATE "item" SET item_price = item_price * 1.1;

--10. Удалить товар № 2.

DELETE FROM "item" WHERE item_id = 2;

--11. Выбрать все товары с сортировкой по названию.

SELECT * FROM "item" ORDER BY item_title;

--12. Выбрать все товары с сортировкой по убыванию цены.

SELECT * FROM "item" ORDER BY item_price DESC;

--13. Выбрать 3 самых дорогих товара.

SELECT * FROM "item" ORDER BY item_price DESC LIMIT 3;

--14. Выбрать 3 самых дешевых товара.

SELECT * FROM "item" ORDER BY item_price ASC LIMIT 3;

--15. Выбрать вторую тройку самых дорогих товаров (с 4 по 6).

SELECT * FROM "item" ORDER BY item_price DESC LIMIT 3 OFFSET 1;

--16. Выбрать наименование самого дорогого товара.

SELECT item_title FROM "item" WHERE item_price = ( SELECT MAX(item_price) FROM "item" ); --var1 result:one row
SELECT * FROM "item" ORDER BY item_price DESC LIMIT 1; --var2 result:table

--17. Выбрать наименование самого дешевого товара.

SELECT item_title FROM "item" WHERE item_price = ( SELECT MIN(item_price) FROM "item" ); --var1
SELECT * FROM "item" ORDER BY item_price ASC LIMIT 1; --var2

--18. Выбрать количество всех товаров.

SELECT count(*) FROM item;

--19. Выбрать среднюю цену всех товаров.

SELECT AVG(item_price) FROM "item";
