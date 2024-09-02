--Explorar la tabla “menu_items” para conocer los productos del menú.
SELECT * FROM menu_items

-- 1.- Realizar consultas para contestar las siguientes preguntas:
-- ● Encontrar el número de artículos en el menú. R=32
SELECT COUNT(DISTINCT item_name) as "number"
FROM menu_items
	
-- ● ¿Cuál es el artículo menos caro y el más caro en el menú? R= más caro: Shrimp Scampi; 19.95 USD, menos caro: Edamame; 5 USD
	select item_name, price 
	from menu_items
	where price = (
	select max (price) from menu_items)

	select item_name, price 
	from menu_items
	where price = (
	select min (price) from menu_items)
-- ● ¿Cuántos platos americanos hay en el menú? R= 6 platillos
	select count (category )
from menu_items
where category = 'American'
	
-- ● ¿Cuál es el precio promedio de los platos? R= 13.29 USD
select round(avg (price), 2)
from menu_items
	

-- c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
	select * from order_details
	
-- 1.- Realizar consultas para contestar las siguientes preguntas:
-- ● ¿Cuántos pedidos únicos se realizaron en total? R= 12234
	select count (order_details_id)
	from order_details
	
-- ● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos? R= 440, 2675, 3473, 4305 y 443
	select order_id, count(item_id)
	from order_details
	group by order_id
	order by count(item_id) desc
	limit 5
	
-- ● ¿Cuándo se realizó el primer pedido y el último pedido? 
--primer pedido R= 01 de Enero de 2023
	select order_date, order_id 
	from order_details
	order by order_date asc
	limit 1
-- último pedido R= 31 de marzo de 2023
	select order_date, order_id 
	from order_details
	order by order_date desc
	limit 1
-- ● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'? R= 72
	select count (order_id)
	from order_details
	where order_date between '2023-01-01' and '2023-01-05'
	
-- d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
	
-- 1.- Realizar un left join entre entre order_details y menu_items con el identificador item_id(tabla order_details) y menu_item_id(tabla menu_items).
SELECT *
FROM ORDER_DETAILS AS o
LEFT JOIN MENU_ITEMS AS m
ON O.ITEM_ID=M.MENU_item_id

--1 ¿Cuales son los 3 platillos más pedidos? R=Hamburguesa, Edamame y Korean Beef Bowl
SELECT count(o.order_id), m.item_name
FROM ORDER_DETAILS AS o
LEFT JOIN MENU_ITEMS AS m
ON O.ITEM_ID=M.MENU_item_id
group by m.item_name
order by count(o.order_id) desc 
limit 3

--2 ¿En qué mes hubo menos ganancia? R= Febrero
SELECT DATE_TRUNC('month', o.order_date) AS mes,
sum(m.price) as total_ventas
FROM ORDER_DETAILS AS o
LEFT JOIN MENU_ITEMS AS m
ON O.ITEM_ID=M.MENU_item_id
group by mes
order by total_ventas asc
limit 1;


--3 ¿Qué categoría de comida es la que representa mayor ganancia? R=Korean Beef
SELECT item_name,
sum (m.price) as total_ventas
FROM ORDER_DETAILS AS o
LEFT JOIN MENU_ITEMS AS m
ON O.ITEM_ID=M.MENU_item_id
WHERE m.price IS NOT NULL
group by item_name
order by total_ventas desc
limit 1;

--4 ¿Cuales son los 5 platillos menos solicitados? R= chicken tacos, potstickers, steak tacos, cheese lasagna y chips & guacamole
SELECT item_name, sum (order_details_id)
FROM ORDER_DETAILS AS o
LEFT JOIN MENU_ITEMS AS m
ON O.ITEM_ID=M.MENU_item_id
where item_name is not null
group by item_name
order by sum (order_details_id) asc
limit 5;
--5 ¿Cuál es la comida asiática más vendida?R= Edamame
SELECT category, item_name, count (o.order_details_id) as total_ventas
FROM ORDER_DETAILS AS o
LEFT JOIN MENU_ITEMS AS m
ON O.ITEM_ID=M.MENU_item_id
where m.category= 'Asian'
group by category, item_name
order by total_ventas desc
limit 1;

