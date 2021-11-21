-- @author Duc Vo
-- Nov 9 2021

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

-- subquery ALL AND ANY
select film_id, title, count(film_id) * avg(replacement_cost) as inventory_film_cost  from film
join inventory using (film_id) group by film_id having inventory_film_cost > ALL ( 
   select count(film_id) * avg(replacement_cost)
	from film
	join inventory using (film_id)
	group by film_id
	having film_id in (
		select film_id from film
		where language_id in (
			select language_id from language
			where name = "Japanese" 
		)
	) 
);

-- subquery ANY (DOESN'T Really make sense does it?)
select film_id, title, count(film_id) * avg(replacement_cost) as inventory_film_cost  from film
join inventory using (film_id) group by film_id having inventory_film_cost > ANY ( 
   select count(film_id) * avg(replacement_cost)
	from film
	join inventory using (film_id)
	group by film_id
	having film_id in (
		select film_id from film
		where language_id in (
			select language_id from language
			where name = "Japanese" 
		)
	) 
);                       
            
	
-- FROM SUBQUERIES
select distinct customer.customer_id, customer.last_name 
from customer,
	(select payment.customer_id from payment join rental using(rental_id) join inventory using (inventory_id) join film using (film_id)
    where film.film_id = 131) CF1,
    (select payment.customer_id from payment join rental using(rental_id) join inventory using (inventory_id) join film using (film_id)
    where film.film_id = 975) CF2
where customer.customer_id = cf1.customer_id and cf1.customer_id = cf2.customer_id;


-- Attribute LIST SUBQUERIES
select film.film_id, rental_rate, (select avg(rental_rate) from film) as avgprice,
	rental_rate-(select avg(rental_rate) from film) as diff
from film;

-- correlated subquery  (Does outer first, then inner. This passes the first P_CODE from outer, and then calcs the average for that product)
select payment_id, rental_id, film_id, rental_rate
from film fl join inventory using (film_id) join rental using(inventory_id) join payment using (rental_id)
where rental_rate > (select avg(rental_rate)
						from film fa
						where fa.film_id = fl.film_id);
					
-- exists query (correlated)   exists is only for subquerys
select customer_id, last_name, first_name
from customer
where exists (select customer_id from payment
				where payment.customer_id =
                customer.customer_id);

-- This doesn't work
select payment.payment_id, customer.customer_id, first_name, last_name
from customer, payment
where payment.customer_id = customer.customer_id
order by payment_id;

-- Date time queries
SELECT DAYOFMONTH('2001-11-10'), MONTH('2005-03-05');
SELECT ADDDATE('2008-01-02', 31);
select customer_id, return_date, day(return_date)
from rental where day(return_date) < 15;

-- Case SQL Statements
select lower(last_name) from staff;
select upper(last_name) from staff;
select first_name, last_name from staff where lower(last_name) like 'step%';

-- Create another Table Similar to another table
drop table  if exists customer_2;
CREATE TABLE CUSTOMER_2 (
customer_id int,
last_name varchar(45),
first_name varchar(45),
email varchar(50),
active tinyint(1),
create_date datetime,
last_update timestamp,
address_id smallint,
store_id tinyint
);

-- Populate a Table similar to another table
INSERT INTO CUSTOMER_2 VALUES(345,'Terrell','Justine','tjustine@abc.com','1', '2021-11-09','2021-11-09', 57, 2) ;
INSERT INTO CUSTOMER_2 VALUES(347,'Olowski','Paul','OlowskiPaul@abc.com','1', '2021-11-03','2021-11-09', 57, 1) ;
INSERT INTO CUSTOMER_2 VALUES(351,'Hernandez','Carlos','McDowellCarlos@abc.com','1', '2021-11-01','2021-11-09', 57, 1) ;
INSERT INTO CUSTOMER_2 VALUES(352,'McDowell','George',NULL,'1', '2021-11-09','2021-11-04', 57, 2) ;
INSERT INTO CUSTOMER_2 VALUES(365,'Tirpin','Khaleed','TirpinKhaleed@abc.com','1', '2021-10-12','2021-11-09', 57, 2) ;
INSERT INTO CUSTOMER_2 VALUES(368,'Lewis','Marie','MarieLewis@abc.com','1', '2021-4-02','2021-11-09', 57, 2) ;
INSERT INTO CUSTOMER_2 VALUES(369,'Dunne','Leona','LeonaDunne@abc.com','1', '2021-2-05','2021-11-09', 57, 2) ;

-- Create a Union
select customer_id, first_name, email, active
from customer
union
select customer_id, first_name, email, active 
from customer_2;

-- Intersect Query (MYSQL DOES NOT SUPPORT)

select customer_id from customer 
where address_id = 57  and 
customer_id in (SELECT DISTINCT  customer_id from payment);

-- minus alternative
select customer_id from customer 
where address_id = 57 and 
customer_id not in (SELECT DISTINCT  customer_id from payment);

-- create view
drop view if exists film_stats;
create view film_stats as
select SUM(replacement_cost) as TotalCost,
count(film_id) as FilmCount, 
avg(rental_rate) as AverageRentalRate,
max(rental_rate) as MaxRate, 
min(rental_rate) as MinRate, 
avg(rental_duration) as AverageRenTalDuration, 
max(rental_duration) as MaxRenTalDuration, 
min(rental_duration) as MinRenTalDuration
from inventory join film using (film_id) join store using (store_id) 
group by  store_id; 
    
select * from film_stats;


drop trigger if exists before_staff_update;
drop table if exists staffs_audit;

CREATE TABLE staffs_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    changedate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER before_staff_update 
    BEFORE UPDATE ON staff
    FOR EACH ROW 
 INSERT INTO staffs_audit
 SET action = 'update',
     staff_id = OLD.staff_id,
     last_name = OLD.last_name,
     changedate = NOW();     

show triggers;
UPDATE staff
SET 
    last_name = 'Miller'
WHERE
    staff_id = 1;
    
select * from staff;
    
 select * from staffs_audit;
 
drop trigger before_staff_update;
drop table staffs_audit;