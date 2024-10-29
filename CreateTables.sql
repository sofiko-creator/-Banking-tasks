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
