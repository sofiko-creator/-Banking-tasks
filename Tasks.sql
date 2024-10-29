--Task 1. Подготовьте DDL-скрипты создания объектов для приведённой модели: создание таблиц,
--первичных, уникальных, внешних ключей и т.д.

--Task 2. Заполните таблицы примерами из приложенного скрипта.

create table if not exists clients
( id numeric(10) primary key,
  name varchar(1000) not null,
  place_of_birth varchar(1000) not null,
  date_of_birth date not null,
  address varchar(1000) not null,
  passport varchar(100) not null
);
insert into clients values (1, 'Сидоров Иван Петрович', 'Россия, Московская облать, г. Пушкин', to_date('01.01.2001','DD.MM.YYYY'), 'Россия, Московская облать, г. Пушкин, ул. Грибоедова, д. 5', '2222 555555, выдан ОВД г. Пушкин, 10.01.2015');
insert into clients values (2, 'Иванов Петр Сидорович', 'Россия, Московская облать, г. Клин', to_date('01.01.2001','DD.MM.YYYY'), 'Россия, Московская облать, г. Клин, ул. Мясникова, д. 3', '4444 666666, выдан ОВД г. Клин, 10.01.2015');
insert into clients values (3, 'Петров Сиодр Иванович', 'Россия, Московская облать, г. Балашиха', to_date('01.01.2001','DD.MM.YYYY'), 'Россия, Московская облать, г. Балашиха, ул. Пушкина, д. 7', '4444 666666, выдан ОВД г. Клин, 10.01.2015');
Select * from clients;
---------------------------------------------
create table if not exists tarifs
(
	id numeric(10) primary key,
	name varchar(100) not null,
	cost numeric(10, 2) not null
);

insert into tarifs values (1,'Тариф за выдачу кредита', 10);
insert into tarifs values (2,'Тариф за открытие счета', 10);
insert into tarifs values (3,'Тариф за обслуживание карты', 10);
Select * from tarifs;
---------------------------------------------
create table if not exists product_type
( id numeric(10) primary key,
  name varchar(100) not null,
  begin_date date not null,
  end_date date,
  tarif_ref numeric(10) not null,
  constraint prod_type_tar_fk foreign key (tarif_ref) references tarifs(id)
);

insert into product_type values (1, 'КРЕДИТ', to_date('01.01.2018','DD.MM.YYYY'), null, 1);
insert into product_type values (2, 'ДЕПОЗИТ', to_date('01.01.2018','DD.MM.YYYY'), null, 2);
insert into product_type values (3, 'КАРТА', to_date('01.01.2018','DD.MM.YYYY'), null, 3);
Select * from product_type;
---------------------------------------------
create table if not exists products
( id numeric(10) primary key,
  product_type_id numeric(10) not null,
  name varchar(100) not null,
  client_ref numeric(10) not null,
  open_date date not null,
  close_date date,
  constraint prod_cl_fk foreign key (client_ref) references clients(id),
  constraint prod_prodtype_fk foreign key (product_type_id) references product_type(id)
);

insert into products values (1, 1, 'Кредитный договор с Сидоровым И.П.', 1, to_date('01.06.2015','DD.MM.YYYY'), null);
insert into products values (2, 2, 'Депозитный договор с Ивановым П.С.', 2, to_date('01.08.2017','DD.MM.YYYY'), null);
insert into products values (3, 3, 'Карточный договор с Петровым С.И.', 3, to_date('01.08.2017','DD.MM.YYYY'), null);
Select * from products;
---------------------------------------------
create table if not exists accounts
( id numeric(10) primary key,
  name varchar(100) not null,
  saldo numeric(10,2) not null,
  client_ref numeric(10) not null,
  open_date date not null,
  close_date date, 
  product_ref numeric(10) not null,
  acc_num varchar(25) not null,
  constraint acc_cl_fk foreign key (client_ref) references clients(id),
  constraint acc_prod_fk foreign key (product_ref) references products(id)
);

insert into accounts values (1, 'Кредитный счет для Сидоровым И.П.', -2000, 1, to_date('01.06.2015','DD.MM.YYYY'), null, 1, '45502810401020000022');
insert into accounts values (2, 'Депозитный счет для Ивановым П.С.', 6000, 2, to_date('01.08.2017','DD.MM.YYYY'), null, 2, '42301810400000000001');
insert into accounts values (3, 'Карточный счет для Петровым С.И.', 8000, 3, to_date('01.08.2017','DD.MM.YYYY'), null, 3, '40817810700000000001');
Select * from accounts;
---------------------------------------------
create table if not exists records
( id numeric(10) primary key,
  dt numeric(1) check (dt IN (0, 1)) not null,
  sum numeric(10,2) not null,
  acc_ref numeric(10) not null,
  oper_date date not null,
  constraint rec_acc_fk foreign key (acc_ref) references accounts(id) 
);
insert into records values (1, 1, 5000, 1, to_date('01.06.2015','DD.MM.YYYY'));
insert into records values (2, 0, 1000, 1, to_date('01.07.2015','DD.MM.YYYY'));
insert into records values (3, 0, 2000, 1, to_date('01.08.2015','DD.MM.YYYY'));
insert into records values (4, 0, 3000, 1, to_date('01.09.2015','DD.MM.YYYY'));
insert into records values (5, 1, 5000, 1, to_date('01.10.2015','DD.MM.YYYY'));
insert into records values (6, 0, 3000, 1, to_date('01.10.2015','DD.MM.YYYY'));

insert into records values (7, 0, 10000, 2, to_date('01.08.2017','DD.MM.YYYY'));
insert into records values (8, 1, 1000, 2, to_date('05.08.2017','DD.MM.YYYY'));
insert into records values (9, 1, 2000, 2, to_date('21.09.2017','DD.MM.YYYY'));
insert into records values (10, 1, 5000, 2, to_date('24.10.2017','DD.MM.YYYY'));
insert into records values (11, 0, 6000, 2, to_date('26.11.2017','DD.MM.YYYY'));

insert into records values (12, 0, 120000, 3, to_date('08.09.2017','DD.MM.YYYY'));
insert into records values (13, 1, 1000, 3, to_date('05.10.2017','DD.MM.YYYY'));
insert into records values (14, 1, 2000, 3, to_date('21.10.2017','DD.MM.YYYY'));
insert into records values (15, 1, 5000, 3, to_date('24.10.2017','DD.MM.YYYY'));
Select * from records;

--Task 3 выполняется в дальнейших заданиях.

--Task 4. Сформируйте отчет, который содержит все счета, относящиеся к продуктам типа ДЕПОЗИТ, 
--принадлежащих клиентам, у которых нет открытых продуктов типа КРЕДИТ.
Select result.id from 
(
Select records.id from records
	Join accounts on records.acc_ref = accounts.id 
	Join clients on accounts.client_ref = clients.id
	Join products on products.client_ref = clients.id
	Join product_type on product_type.id = products.product_type_id
Where product_type.name = 'ДЕПОЗИТ'
Except --разность двух выборок
( 
	Select records.id from records
		Join accounts on records.acc_ref = accounts.id 
		Join clients on accounts.client_ref = clients.id
		Join products on products.client_ref = clients.id
		Join product_type on product_type.id = products.product_type_id
	Where product_type.name = 'ДЕПОЗИТ'
Intersect --пересечение двух выборок
	( 
	Select records.id from records
		Join accounts on records.acc_ref = accounts.id 
		Join clients on accounts.client_ref = clients.id
		Join products on products.client_ref = clients.id
		Join product_type on product_type.id = products.product_type_id
	Where product_type.name = 'КРЕДИТ'
	)
)
) as result
Order by result.id ASC;

--Добавим записи для теста, чтобы были клиенты, у которых открыт
--и депозит и кредит
insert into clients values 
(4, 'Чернова Софья Алексеевна', 'Россия, Красноярский край, г. Абакан', to_date('02.02.2002','DD.MM.YYYY'), 'Россия, Новосибирская облать, г. Новосибирск, ул. Метелкина, д. 72', '7777 555555, выдан ОВД г. Новосибирск, 11.02.2010');
insert into products values (4, 2, 'Депозитный договор с Черновой С.А.', 4, to_date('02.02.2015','DD.MM.YYYY'), null);
insert into products values (5, 2, 'Депозитный договор с Сидоровым И.П.', 1, to_date('13.03.2016','DD.MM.YYYY'), null);

insert into accounts values (4, 'Депозитный счет для Черновой С.А.', 5000, 4, to_date('02.02.2015','DD.MM.YYYY'), null, 4, '77701810400000000007');
insert into accounts values (5, 'Депозитный счет для Сидоровым И.П.', 2000, 1, to_date('13.03.2016','DD.MM.YYYY'), null, 5, '46606770801020000011');

insert into records values (16, 0, 1000, 4, to_date('20.07.2016','DD.MM.YYYY'));
insert into records values (17, 1, 500, 4, to_date('12.09.2017','DD.MM.YYYY'));

insert into records values (18, 0, 1100, 5, to_date('21.01.2018','DD.MM.YYYY'));
insert into records values (19, 1, 600, 5, to_date('19.04.2019','DD.MM.YYYY'));

--Task 5. Сформируйте выборку, который содержит средние 
--движения по счетам в рамках одного произвольного дня, 
--в разрезе типа продукта.
Select AVG(records.sum), product_type.name as product_type_name, oper_date from records
	Join accounts on records.acc_ref = accounts.id 
	Join products on accounts.product_ref = products.id
	Join product_type on product_type.id = products.product_type_id
Where records.oper_date = '11.11.2020'
Group by product_type.name, oper_date
Order by AVG(records.sum)

--Добавим записи для теста, чтобы был один повторяющийся день в операциях
--по кредиту
insert into records values (20, 1, 5000, 1, to_date('11.11.2020','DD.MM.YYYY'));
insert into records values (21, 0, 3000, 1, to_date('11.11.2020','DD.MM.YYYY'));

--по депозиту
insert into records values (22, 0, 1100, 5, to_date('11.11.2020','DD.MM.YYYY'));
insert into records values (23, 1, 600, 5, to_date('11.11.2020','DD.MM.YYYY'));

--по депозиту
insert into records values (24, 0, 900, 4, to_date('11.11.2020','DD.MM.YYYY'));
insert into records values (25, 1, 500, 4, to_date('11.11.2020','DD.MM.YYYY'));

--по карте
insert into records values (26, 1, 2000, 3, to_date('11.11.2020','DD.MM.YYYY'));
insert into records values (27, 1, 5000, 3, to_date('11.11.2020','DD.MM.YYYY'));

--Task 6. Сформируйте выборку, в который попадут клиенты, у которых были операции 
--по счетам за прошедший месяц от текущей даты. 
--Выведите клиента и сумму операций за день в разрезе даты.
Select clients.name, sum(records.sum), oper_date from clients
Join accounts on clients.id = accounts.client_ref
Join records on accounts.id = records.acc_ref
Where oper_date between current_date - interval '1 month' and current_date
Group by clients.name, oper_date
order by clients.name, oper_date

--Добавим записи для теста, чтобы даты за месяц от текущей существовали
insert into records values (28, 1, 1000, 1, to_date('30.08.2024','DD.MM.YYYY'));
insert into records values (29, 0, 2000, 1, to_date('30.08.2024','DD.MM.YYYY'));

insert into records values (30, 0, 1400, 5, to_date('29.08.2024','DD.MM.YYYY'));
insert into records values (31, 1, 600, 5, to_date('29.08.2024','DD.MM.YYYY'));

insert into records values (32, 1, 3000, 3, to_date('28.08.2024','DD.MM.YYYY'));
insert into records values (33, 1, 4000, 3, to_date('28.08.2024','DD.MM.YYYY'));

-- Task 7. В результате сбоя в базе данных разъехалась информация между остатками и операциями по счетам. 
--Напишите нормализацию (процедуру выравнивающую данные), которая найдет такие счета и восстановит остатки по счету.
Create or replace function normalization_of_accounts()
Returns void as 
$$
Begin
	Update accounts as a
	Set saldo = coalesce(u.update_saldo, 0) 
	From (
		Select acc_ref, SUM(case when dt = 0 then sum
						    when dt = 1 then -sum
						    else 0 end) as update_saldo
		From records
		Group by acc_ref
	) u
	Where a.id = u.acc_ref and a.saldo != u.update_saldo;
	RAISE NOTICE 'Остатки по счетам были обновлены и выровнены';
End; 
$$
LANGUAGE plpgsql;

--вызов функции
Select normalization_of_accounts();

--проверка состояния остатков на счетах (при повторном запуске функции состояние остатков остается прежним)
Select clients.id as client_id, clients.name as client_name, products.name as product_name, product_type.name as product_type, accounts.saldo
From clients 
Join products on clients.id = products.client_ref
Join product_type on products.product_type_id = product_type.id
Join accounts on products.id = accounts.product_ref
where clients.id = 1

--Task 8. Сформируйте выборку, который содержит информацию о клиентах, 
--которые полностью погасили кредит, 
--но при этом не закрыли продукт и пользуются им дальше (по продукту есть операция новой выдачи кредита).
Select clients.name from clients
Join accounts on clients.id = accounts.client_ref
Join products on products.id = accounts.product_ref 
Join product_type on product_type.id = products.product_type_id
Where product_type.name = 'КРЕДИТ' and products.close_date is NULL and accounts.saldo = 0
And exists 
(
	Select records.id from records 
	Where records.acc_ref = accounts.id and records.dt = 1 and records.oper_date > products.open_date
)
--Внесём сумму для погашения кредита для "Сидоров Иван Петрович"
insert into records values (34, 0, 2000, 1, to_date('01.09.2024','DD.MM.YYYY'));
--Обновим данные
Select normalization_of_accounts();
--Проверим погашение
Select clients.id as client_id, clients.name as client_name, products.name as product_name, product_type.name as product_type, accounts.saldo
From clients 
Join products on clients.id = products.client_ref
Join product_type on products.product_type_id = product_type.id
Join accounts on products.id = accounts.product_ref
where clients.id = 1 -- кредит обнулился проверка прошла

--Добавим операцию по продукту новой выдачи кредита для "Сидоров Иван Петрович"
insert into records values (35, 1, 10000, 1, to_date('02.09.2024','DD.MM.YYYY'));
--Погасим его
insert into records values (36, 0, 10000, 1, to_date('02.09.2024','DD.MM.YYYY'));

--Task 9. Закройте продукты (установите дату закрытия равную текущей) типа КРЕДИТ, 
--у которых произошло полное погашение, но при этом не было повторной выдачи.
Create or replace function close_type_products()
Returns void as
$$
Begin
	Update products as p
	Set close_date = current_date
	From(
		Select products.id, clients.name from clients
		Join accounts on clients.id = accounts.client_ref
		Join products on products.id = accounts.product_ref 
		Join product_type on product_type.id = products.product_type_id
		Where product_type.name = 'КРЕДИТ' and products.close_date is NULL and accounts.saldo = 0
		And not exists 
		(
			Select records.id from records 
			Where records.acc_ref = accounts.id and records.dt = 1 and records.oper_date > products.open_date
		)
	) u
	Where u.id = p.id;
	RAISE NOTICE 'Даты закрытия для некоторых продуктов типа КРЕДИТ установлены';
End; 
$$
LANGUAGE plpgsql;

--Откроем кредит для Гладуненко Валентина Олеговича
insert into clients values 
(5, 'Гладуненко Валентин Олегович', 'Россия, Краснодарский Край, г. Сочи', to_date('07.03.2002','DD.MM.YYYY'), 'Россия, Новосибирская облать, г. Новосибирск, ул. Ленина, д. 72', '7744 555544, выдан ОВД г. Новосибирск, 11.02.2010');
insert into products values (6, 1, 'Кредитный договор с Гладуненко В.О.', 5, to_date('01.06.2018','DD.MM.YYYY'), null);
insert into accounts values (6, 'Кредитный счет для Гладуненко В.О.', -20000, 5, to_date('01.06.2018','DD.MM.YYYY'), null, 6, '32203310301330000044');
insert into records values (37, 1, 20000, 6, to_date('01.06.2018','DD.MM.YYYY')); -- операция выдачи кредита
-- погасим кредит Гладуненко Валентина Олеговича
insert into records values (38, 0, 10000, 6, to_date('01.06.2021','DD.MM.YYYY'));
insert into records values (39, 0, 10000, 6, to_date('01.06.2021','DD.MM.YYYY'));
--Обновим данные
Select normalization_of_accounts();
--Проверим погашение
Select clients.id as client_id, clients.name as client_name, products.name as product_name, product_type.name as product_type, accounts.saldo
From clients 
Join products on clients.id = products.client_ref
Join product_type on products.product_type_id = product_type.id
Join accounts on products.id = accounts.product_ref
where clients.id = 5 -- кредит обнулился проверка прошла
 
--Вызовем функцию и проверим дату закрытия
Select close_type_products();
Select * from products; -- дата закрытия кредита для Гладуненко В.О. была установлена

--Task 10. Закройте возможность открытия (установите дату окончания действия) для типов продуктов, 
--по счетам продуктов которых, не было движений более одного месяца.
Create or replace function close_type_products()
Returns void as
$$
Begin
	Update product_type as pt
	Set end_date = current_date
	From (
		Select Max(oper_date) as max_oper_date, product_type.id from records
		Join accounts on accounts.id = records.acc_ref
		Join products on products.id = accounts.product_ref
		Join product_type on product_type.id = products.product_type_id	
		Group by product_type.id
	) u
	Where u.id = pt.id and u.max_oper_date < current_date - interval '1 month';
	RAISE NOTICE 'Даты окончания действия для некоторых типов продуктов установлены';
End; 
$$
LANGUAGE plpgsql;

--Установим для карты последнее движение на несколько месяцев назад
UPDATE records
SET oper_date = '28.06.2024'
FROM (
    SELECT records.id
    FROM records
    JOIN accounts ON accounts.id = records.acc_ref
    JOIN products ON products.id = accounts.product_ref
    JOIN product_type ON product_type.id = products.product_type_id
    WHERE records.oper_date = '28.08.2024'
      AND product_type.id = 3
) AS subquery
WHERE records.id = subquery.id;

-- Вызовем функцию и проверим статус закрытия КАРТЫ
Select close_type_products();
Select * from product_type; -- Для типа продукта карта установлена дата окончания действия

--Task 11. В модель данных добавьте сумму договора по продукту. 
--Заполните поле для всех продуктов суммой максимальной дебетовой операции по счету для продукта типа КРЕДИТ, 
--и суммой максимальной кредитовой операции по счету продукта для продукта типа ДЕПОЗИТ или КАРТА.
 
-- Добавим поле для суммы договора по продукту в таблицу products
Alter table products add column contract_amount numeric(10,2);

Create or replace function fill_the_contract_amount_for_credit()
Returns void as
$$
Begin
 Update products 
 Set contract_amount = coalesce(u.update_contract_amount, 0)
 From(
	 Select accounts.product_ref, max(records.sum) as update_contract_amount from records
	 Join accounts on accounts.id = records.acc_ref
	 Where records.dt = 1 -- Дебетовая операция
	 Group by accounts.product_ref
 ) u
 Where u.product_ref = products.id and products.product_type_id = 1;
 RAISE NOTICE 'Суммы договоров для всех продуктов типа кредит заполнены';
End;
$$
LANGUAGE plpgsql;
Select fill_the_contract_amount_for_credit();

Create or replace function fill_the_contract_amount_for_deposit()
Returns void as
$$
Begin
 Update products 
 Set contract_amount = coalesce(u.update_contract_amount, 0)
 From(
	 Select accounts.product_ref, max(records.sum) as update_contract_amount from records
	 Join accounts on accounts.id = records.acc_ref
	 Where records.dt = 0 -- Кредитовая операция
	 Group by accounts.product_ref
 ) u
 Where u.product_ref = products.id and products.product_type_id = 2;
 RAISE NOTICE 'Суммы договоров для всех продуктов типа депозит заполнены';
End;
$$
LANGUAGE plpgsql;
Select fill_the_contract_amount_for_deposit();

--Проверим заполнение нового поля таблицы products
Select * from products
Order by id; 