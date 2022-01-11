-- Student: Eliyahu Levinson

--- 1.
select id, fname, lname
from customer
where customer.id > (
    select max(id)
    from customer
    where customer.state = 'TX');
select char(10);

--- 2.
select fname
from customer
where customer.address like '%x%';
SELECT char(10);

--- 3.
select C.id, C.fname, C.lname
from customer C, sales_order S
where C.id = S.cust_id AND NOT exists (
    select *
    from sales_order
    where sales_order.cust_id = S.cust_id AND 
        sales_order.order_date NOT like '1994-%')
group by cust_id;
SELECT char(10);

--- 4.
select distinct P.name, P.description
from customer C, sales_order S, sales_order_items I, product P
where C.id = S.cust_id AND
    S.id = I.id AND 
    I.prod_id = P.id AND 
    C.fname like 'E%'
order by P.name ASC;
SELECT char(10);

--- 5.
select distinct C.id, C.fname, C.lname
from customer C
where C.id in (
    select customer.id
    from customer
        EXCEPT
    select sales_order.cust_id
    from sales_order
);
SELECT char(10);

--- 6.
select distinct C.id, C.fname, C.lname
from customer C
where C.id in (
    select sales_order.cust_id
    from sales_order
) AND not exists (
    select P.name
    from customer, sales_order S, sales_order_items I, product P
    where customer.id = C.id AND 
        C.id = S.cust_id AND 
        S.id = I.id AND 
        I.prod_id = P.id AND 
        P.name like '%shirt%'
);
SELECT char(10);

--- 7.
select  distinct C.id, C.fname, C.lname
from customer C
where C.id in (
    select sales_order.cust_id
    from sales_order
) AND not exists (
    select *
    from sales_order S, employee E
    where C.id = S.cust_id AND
        S.sales_rep = E.emp_id AND NOT
        E.emp_id = 299
);
SELECT char(10);

--- 8.
select distinct D.dept_id, D.dept_name, count(E.emp_id), avg(E.salary)
from department D, employee E
where E.dept_id = D.dept_id
group by D.dept_name;
SELECT char(10);

--- 9.
select distinct E.emp_id, E.emp_fname, count(S.id)
from employee E, sales_order S
where S.sales_rep = E.emp_id
group by E.emp_id;
SELECT char(10);

--- 10.
select distinct max(S.order_date)
from sales_order S;
SELECT char(10);

--- 11.
select distinct C.state
from customer C
group by C.state
having count(C.id) >= (
    select distinct count(*) as num_customer
    from customer
    group by state
    order by num_customer desc);
SELECT char(10);

--- 12.
select distinct C.id, C.fname, C.lname, count(S.id)
from customer C, sales_order S
where C.id = S.cust_id AND
    S.sales_rep = 129
group by C.id;
SELECT char(10);

--- 13.
create view if not exists order_price as
select I.id, P.quantity * P.unit_price * I.quantity as orderPrice
from sales_order_items I, product P
where I.prod_id = P.id
group by I.id;

select sum(orderPrice)
from order_price
where id in (
    select id 
    from sales_order
    where sales_order.cust_id = 101
);
SELECT char(10);

--- 14.
create view if not exists age_employee as 
select E.emp_id, date('now') - E.birth_date as age
from employee E;

select D.dept_name, avg(A.age)
from age_employee A, department D
group by D.dept_id;
SELECT char(10);

--- 15.
create table if not exists manufacturer (
    id int,
    manuf_name char(125),
    address char(125),
    balance int,
    primary key (id)
);

--- 16.
insert or replace into manufacturer values (0, "Mishon", "HaAtsmaut 53, Yavne", 1009);
insert or replace into manufacturer values (1, "Migel", "Jerusalem 61, Yavne", 2100);
insert or replace into manufacturer values (2, "Richard", "Karlibah 12, Krayot", 5117);

select *
from manufacturer;
SELECT char(10);

--- 17.
select distinct "eliyahu levinson, 012345678" from manufacturer;
