1) ---------------------------------------------------------
select 
    distinct
    key1,key2,val_1,val_2,str_1
from mart_1
where key_1 is not null
      
Тут можно val_1 и val_2 написать условие, чтобы выводились тока числовые значения откидывая тестовые, также
на str_1 пишем чтобы он не вставлял поля к примеру 16 разрядные(всякие кракозябры).
При создании таблицы поле key_1 сделать уникальным, если числа должны быть положительными можно сделать проверку check val_1(2) >= 0.
Сделать проверку на null вставку данных, чтобы сразу понимать что данные не полные пришли с источника.


2) ---------------------------------------------------------
![Image alt](https://github.com/SergeyPerm59/dwh_test/blob/main/img_1.png)

Например у нас данные записываются в hub1 и у него есть sattelit Sat_tab_1, когда мы удаляем (1,20), у нас в саттелите ставится метка дата LoadEndDate и данная запись не будет больше выводиться.

--создаем хабы
drop table if exists Hub_tab_1;
create table Hub_tab_1 (
	hub1_hash_key varchar(32) primary key,
	LoadDate timestamp not null,
	RecordSource varchar(50) not null,
	id int not null
);

drop table if exists Hub_tab_2;
create table Hub_tab_2 (
	hub2_hash_key varchar(32) primary key,
	LoadDate timestamp not null,
	RecordSource varchar(50) not null,
	id int not null
);

--Создаем линк

drop table if exists l_hub1_hub2;
create table l_hub1_hub2 (
	link_hash_key varchar(32) primary key,
	LoadDate timestamp not null,
	RecordSource varchar(50) not null,
	hub_hash_key1 varchar(32) references Hub_tab_1(hub1_hash_key),
	hub_hash_key2 varchar(32) references Hub_tab_2(hub2_hash_key)
);

--Создаем сателит

drop table if exists Sat_tab_1;
create table Sat_tab_1 (
	hub1_hash_key varchar(32) not null references Hub_tab_1(hub1_hash_key),
	LoadDate timestamp not null,
	LoadEndDate timestamp not null,
	RecordSource varchar(50) not null,
	HashDiff varchar(32) not null,
	id_hub1 int not null,
	id_hub2 int not null,
	PRIMARY KEY (hub1_hash_key, LoadDate)
);

3) ---------------------------------------------------------
 

drop table if exists client_day_balance;
CREATE TABLE client_day_balance (
id_client int4 NOT NULL,
fio varchar(60) NOT NULL,
balance numeric(14, 2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
data_day date,
) PARTITION BY RANGE (data_day);

В задании не написано нужно загружать с 0 балансом клиентов, поэтому беру клиентов у кого баланс > 0 и по текущей дате 
insert into client_day_bal_ost
select
    id_client,
    fio,
    balance
    data_day
from client_day_balance
where data_day = sysdate and balance > 0

4) ---------------------------------------------------------

Создаем таблицу с партицирование по дате на месяц. Партицирование облегчает работу с витриной.

Валидацию может быть: 
Полная - без пустых и нулевых значений
Уникальная - получается значения не повторяются unique
Проверка на соответсвие например десятичная дробь в каком то диапазоне.

Пример почтовый индекс в таблице клиента, нам нужно убедиться что он имеет числовой формат и правильную длину.
Проверить что у нас строка не нулевая.
Напимер установить диапазон зарпал чтобы не было нюансов потом при выдаче. (check > 500.00 and < 1000.00)
Больше не работал с валидацией.

5) ---------------------------------------------------------

create table tt
(
    id1, -- ссылка на таблицу t1
    id2, -- ссылка на таблицу t2
    id3, -- ссылка на таблицу t3
    s11, -- строковый артрибут
    s22, -- строковый атрибут
    f21, -- агрегируемый атрибут
    f42, -- агрегируемый атрибут
    unique (id1, id2, id3)
);

 -- data value
 ![Image alt](https://github.com/SergeyPerm59/dwh_test/blob/main/img_2.jpg)
 
 --создаем хабы
drop table if exists Hub_t1;
create table Hub_t1 (
	hub1_hash_key varchar(32) primary key,
	LoadDate timestamp not null,
	RecordSource varchar(50) not null,
	id1 int not null
);

drop table if exists Hub_t2;
create table Hub_t2 (
	hub2_hash_key varchar(32) primary key,
	LoadDate timestamp not null,
	RecordSource varchar(50) not null,
	id2 int not null
);

drop table if exists Hub_t3;
create table Hub_t3 (
	hub2_hash_key varchar(32) primary key,
	LoadDate timestamp not null,
	RecordSource varchar(50) not null,
	id3 int not null
);

--Создаем линк

drop table if exists link_hub_tt;
create table link_hub_tt (
	link_hash_key varchar(32) primary key,
	LoadDate timestamp not null,
	RecordSource varchar(50) not null,
	hub_id1 varchar(32) references Hub_t1(hub1_hash_key),
	hub_id2 varchar(32) references Hub_t2(hub2_hash_key),
    hub_id3 varchar(32) references Hub_t2(hub3_hash_key),
);

--Создаем сателит

drop table if exists Sat_tab_1;
create table Sat_tt (
	link_hash_key varchar(32) not null references Hub_tab_1(hub1_hash_key),
	LoadDate timestamp not null,
	LoadEndDate timestamp not null,
	RecordSource varchar(50) not null,
	s11 varchar(50) not null,
    s22 varchar(50) not null,
    f21 int,
    f42 int,
	PRIMARY KEY (hub1_hash_key, LoadDate)
);

![Image alt](https://github.com/SergeyPerm59/dwh_test/blob/main/img_3.jpg)

-- anchor modeling
Модель была разработана с помощью сайта https://www.anchormodeling.com/modeler/latest/ и сохранена
в файле anchorModel.sql 
