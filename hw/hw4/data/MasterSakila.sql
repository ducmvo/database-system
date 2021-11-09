use sakila;

-- Normal Join  Query #1  (MY PREFERENCE)
select distinct film.film_id, title, rental_rate, store_id
from film, inventory
where film.film_id = inventory.film_id
order by store_id;

-- SHORT CUT (NATURAL JOIN)
select customer_id, last_name, payment_id, payment_date
from customer natural join payment;

-- SHORT CUTS JOIN USING
select payment_id, film_id, title, rental_rate, rental_duration
from payment join rental using (rental_id) join inventory using (inventory_id) join film using (film_id);

-- JOIN ON (HAVE TO USE ACTUAL JOIN COLUMNS)
select payment_id, film.film_id, title, rental_rate, rental_duration
from payment join rental on payment.rental_id = rental.rental_id
join inventory on inventory.inventory_id = rental.inventory_id
join film on inventory.film_id = film.film_id;


-- Left Outer Join (VENDORS who don't have PRODUCTS will show up)
select customer.customer_id, last_name, payment_id, payment_date
from payment left join customer on customer.customer_id = payment.customer_id;

-- Right Outer Join ()
select customer.customer_id, last_name, payment_id, payment_date
from customer right join payment  on customer.customer_id = payment.customer_id;

-- subqueries
select payment_id, customer.customer_id, last_name, first_name
from customer, payment
where customer.customer_id = payment.customer_id;

-- Subquery doesn't work
select inventory_id
from inventory 
where not exists (select film_id from film where inventory.film_id = film.film_id);


-- subquery with where AWESOME QUERY
select film_id, rental_rate from film
where rental_rate >= (select avg(rental_rate) from film);

-- subquery with where 
select distinct customer.customer_id, last_name, first_name
from customer join payment using (customer_id)
join rental using (rental_id)
join inventory using (inventory_id)
join film using (film_id)
where film_id = (select film_id from film where title='LOST BIRD');


-- Similar
select distinct customer.customer_id, last_name, first_name, title
from customer join payment using (customer_id)
join rental using (rental_id)
join inventory using (inventory_id)
join film using (film_id)
where title like 'STALLION%';

-- in SubQueries
select distinct customer.customer_id, last_name, first_name, title
from customer join payment using (customer_id)
join rental using (rental_id)
join inventory using (inventory_id)
join film using (film_id)
where film_id in (select film_id from film
					where title like '%LION%'
					or title like '%BIRD%');
                    
-- in SubQueries  (SAME)
select distinct customer.customer_id, last_name, first_name, title
from customer join payment using (customer_id)
join rental using (rental_id)
join inventory using (inventory_id)
join film using (film_id)
where title  like '%FIRE%' or title like '%DRAGON%';
    
    
select film_id, count(film_id) from inventory group by film_id;
    
-- subquery HAVING
select customer_id, sum(amount)
from payment
group by customer_id
-- where sum(amount) > AVG(amount); -- Can't do this, that is why having
having sum(amount) > (select avg(sumamount) from (
	select sum(amount) as sumamount from payment
	group by customer_id
) as sumamountbycustomer);

;


-- ==============================================================


-- subquery ALL AND ANY
select p_code, p_qoh*p_price
from product
where p_qoh*p_price > ALL(SELECT P_QOH * P_PRICE
						from product 
						where v_code in (select v_code
                        from vendor
                        where v_state='FL'));

-- subquery ANY (DOESN'T Really make sense does it?)
select p_code, p_qoh*p_price
from product
where p_qoh*p_price > ANY(SELECT P_QOH * P_PRICE
						from product 
						where v_code in (select v_code
                        from vendor
                        where v_state='FL'));                        
                        
                        
-- FROM SUBQUERIES
select distinct customer.cus_code, customer.cus_lname 
from customer,
	(select invoice.cus_code from invoice natural join line
    where p_code='13-Q2/P2') CP1,
    (select invoice.cus_code from invoice natural join line
    where p_code='23109-HB') CP2
where customer.cus_code=cp1.cus_code and cp1.cus_code=cp2.cus_code;

-- Attribute LIST SUBQUERIES
select p_code, p_price, (select avg(p_price) from product) as avgprice,
	p_price-(select avg(p_price) from product) as diff
from product;

-- correlated subquery  (Does outer first, then inner. This passes the first P_CODE from outer, and then calcs the average for that product)
select inv_number, line_number, p_code, line_units
from line ls
where ls.line_units > (select avg(line_units)
						from line la
						where la.p_code=ls.p_code);

-- exists query (correlated)   exists is only for subquerys

select cus_code, cus_lname, cus_fname
from customer
where exists (select cus_code from invoice
				where invoice.cus_code=
                customer.cus_code);

-- This doesn't work
select invoice. inv_number, customer.cus_code, cus_lname, cus_fname
from customer, invoice
where invoice.cus_code=
customer.cus_code
order by inv_number;

-- Date time queries
SELECT DAYOFMONTH('2001-11-10'), MONTH('2005-03-05');
SELECT ADDDATE('2008-01-02', 31);
select emp_lname, emp_fname, emp_dob, year(emp_dob) as YEARBORN
from emp where year(emp_dob)> 1959;

-- Case SQL Statements
select lower(emp_lname) from emp;
select upper(emp_lname) from emp;
select emp_lname from emp where lower(emp_lname) like 'smi%';

-- Create another Table Similar to another table
drop table  if exists customer_2;
CREATE TABLE CUSTOMER_2 (
CUS_CODE int,
CUS_LNAME varchar(15),
CUS_FNAME varchar(15),
CUS_INITIAL varchar(1),
CUS_AREACODE varchar(3),
CUS_PHONE varchar(8)

);

-- Populate a Table similar to another table
INSERT INTO CUSTOMER_2 VALUES(345,'Terrell','Justine','H','615','322-9870');
INSERT INTO CUSTOMER_2 VALUES(347,'Olowski','Paul','F',615,'894-2180');
INSERT INTO CUSTOMER_2 VALUES(351,'Hernandez','Carlos','J','723','123-7654');
INSERT INTO CUSTOMER_2 VALUES(352,'McDowell','George',NULL,'723','123-7768');
INSERT INTO CUSTOMER_2 VALUES(365,'Tirpin','Khaleed','G','723','123-9876');
INSERT INTO CUSTOMER_2 VALUES(368,'Lewis','Marie','J','734','332-1789');
INSERT INTO CUSTOMER_2 VALUES(369,'Dunne','Leona','K','713','894-1238');


-- Create a Union
select cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone
from customer
union
select cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone from customer_2;

-- Intersect Query (MYSQL DOES NOT SUPPORT)

select cus_code from customer 
where cus_areacode='615' and 
cus_code in (SELECT DISTINCT  cus_code from invoice);

-- minus alternative
select cus_code from customer 
where cus_areacode='615' and 
cus_code not in (SELECT DISTINCT  cus_code from invoice);

-- create view
drop view if exists prod_stats;

create view prod_stats as
select v_code, sum(P_QOH*p_price) as totcost, max(P_QOH) as Maxqty,
	MIN(P_QOH) AS MINQTY, AVG(p_qoh) AS AVGQTY
    FROM PRODUCT
    GROUP BY V_CODE;
    
select * from prod_stats;


drop trigger if exists before_employe_update;
drop table if exists employees_audit;

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON emp
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.emp_num,
     lastname = OLD.emp_lname,
     changedat = NOW();     

show triggers;
UPDATE emp
SET 
    emp_lname = 'Phan'
WHERE
    emp_num = 100;
    
 select * from employees_audit;
 
drop trigger before_employee_update;
drop table employees_audit;